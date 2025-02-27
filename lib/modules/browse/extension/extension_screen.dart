import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grouped_list/sliver_grouped_list.dart';
import 'package:mangayomi/models/manga.dart';
import 'package:mangayomi/models/source.dart';
import 'package:mangayomi/modules/browse/extension/providers/extensions_provider.dart';
import 'package:mangayomi/services/fetch_anime_sources.dart';
import 'package:mangayomi/services/fetch_manga_sources.dart';
import 'package:mangayomi/modules/widgets/progress_center.dart';
import 'package:mangayomi/providers/l10n_providers.dart';
import 'package:mangayomi/services/fetch_novel_sources.dart';
import 'package:mangayomi/services/fetch_sources_list.dart';
import 'package:mangayomi/utils/language.dart';
import 'package:mangayomi/modules/browse/extension/widgets/extension_list_tile_widget.dart';

class ExtensionScreen extends ConsumerStatefulWidget {
  final ItemType itemType;
  final String query;
  const ExtensionScreen({
    required this.query,
    required this.itemType,
    super.key,
  });

  @override
  ConsumerState<ExtensionScreen> createState() => _ExtensionScreenState();
}

class _ExtensionScreenState extends ConsumerState<ExtensionScreen> {
  final ScrollController controller = ScrollController();
  bool isUpdating = false;
  Future<void> _refreshSources() {
    return switch (widget.itemType) {
      ItemType.manga => ref.refresh(
        fetchMangaSourcesListProvider(id: null, reFresh: true).future,
      ),
      ItemType.anime => ref.refresh(
        fetchAnimeSourcesListProvider(id: null, reFresh: true).future,
      ),
      _ => ref.refresh(
        fetchNovelSourcesListProvider(id: null, reFresh: true).future,
      ),
    };
  }

  Future<void> _updateSource(Source source) {
    switch (source.itemType) {
      case ItemType.manga:
        return ref.read(
          fetchMangaSourcesListProvider(id: source.id, reFresh: true).future,
        );
      case ItemType.anime:
        return ref.read(
          fetchAnimeSourcesListProvider(id: source.id, reFresh: true).future,
        );
      default:
        return ref.read(
          fetchNovelSourcesListProvider(id: source.id, reFresh: true).future,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.itemType) {
      case ItemType.manga:
        ref.read(fetchMangaSourcesListProvider(id: null, reFresh: false));
        break;
      case ItemType.anime:
        ref.read(fetchAnimeSourcesListProvider(id: null, reFresh: false));
        break;
      default:
        ref.read(fetchNovelSourcesListProvider(id: null, reFresh: false));
    }

    final streamExtensions = ref.watch(
      getExtensionsStreamProvider(widget.itemType),
    );

    final l10n = l10nLocalizations(context)!;

    return RefreshIndicator(
      onRefresh: _refreshSources,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: streamExtensions.when(
          data: (data) {
            final filteredData =
                widget.query.isEmpty
                    ? data
                    : data
                        .where(
                          (element) =>
                              element.name?.toLowerCase().contains(
                                widget.query.toLowerCase(),
                              ) ??
                              false,
                        )
                        .toList();

            final updateEntries = <Source>[];
            final installedEntries = <Source>[];
            final notInstalledEntries = <Source>[];

            for (var element in filteredData) {
              final isLatestVersion = element.version == element.versionLast;

              if (compareVersions(
                    element.version ?? '',
                    element.versionLast ?? '',
                  ) <
                  0) {
                updateEntries.add(element);
              } else if (isLatestVersion) {
                if (element.isAdded ?? false) {
                  installedEntries.add(element);
                } else {
                  notInstalledEntries.add(element);
                }
              }
            }

            return Scrollbar(
              interactive: true,
              controller: controller,
              thickness: 12,
              radius: const Radius.circular(10),
              child: CustomScrollView(
                controller: controller,
                slivers: [
                  if (updateEntries.isNotEmpty)
                    _buildUpdateSection(updateEntries, l10n),
                  if (installedEntries.isNotEmpty)
                    _buildInstalledSection(installedEntries, l10n),
                  if (notInstalledEntries.isNotEmpty)
                    _buildNotInstalledSection(notInstalledEntries),
                ],
              ),
            );
          },
          error:
              (error, _) => Center(
                child: ElevatedButton(
                  onPressed: _refreshSources,
                  child: Text(context.l10n.refresh),
                ),
              ),
          loading: () => const ProgressCenter(),
        ),
      ),
    );
  }

  Widget _buildUpdateSection(List<Source> updateEntries, dynamic l10n) {
    return SliverGroupedListView<Source, String>(
      elements: updateEntries,
      groupBy: (_) => "",
      groupSeparatorBuilder:
          (_) => StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.update_pending,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    ElevatedButton(
                      onPressed:
                          isUpdating
                              ? null
                              : () async {
                                setState(() => isUpdating = true);
                                try {
                                  for (var source in updateEntries) {
                                    await _updateSource(source);
                                  }
                                } finally {
                                  setState(() => isUpdating = false);
                                }
                              },
                      child:
                          isUpdating
                              ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                              : Text(l10n.update_all),
                    ),
                  ],
                ),
              );
            },
          ),
      itemBuilder:
          (context, Source element) =>
              ref.watch(extensionListTileWidget(element)),
      groupComparator: (group1, group2) => group1.compareTo(group2),
      itemComparator:
          (item1, item2) => item1.name?.compareTo(item2.name ?? '') ?? 0,
      order: GroupedListOrder.ASC,
    );
  }

  Widget _buildInstalledSection(List<Source> installedEntries, dynamic l10n) {
    return SliverGroupedListView<Source, String>(
      elements: installedEntries,
      groupBy: (_) => "",
      groupSeparatorBuilder:
          (_) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              l10n.installed,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
      itemBuilder:
          (context, Source element) =>
              ref.watch(extensionListTileWidget(element)),
      groupComparator: (group1, group2) => group1.compareTo(group2),
      itemComparator:
          (item1, item2) => item1.name?.compareTo(item2.name ?? '') ?? 0,
      order: GroupedListOrder.ASC,
    );
  }

  Widget _buildNotInstalledSection(List<Source> notInstalledEntries) {
    return SliverGroupedListView<Source, String>(
      elements: notInstalledEntries,
      groupBy:
          (element) => completeLanguageName(element.lang?.toLowerCase() ?? ''),
      groupSeparatorBuilder:
          (String groupByValue) => Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              groupByValue,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
      itemBuilder:
          (context, Source element) =>
              ref.watch(extensionListTileWidget(element)),
      groupComparator: (group1, group2) => group1.compareTo(group2),
      itemComparator:
          (item1, item2) => item1.name?.compareTo(item2.name ?? '') ?? 0,
      order: GroupedListOrder.ASC,
    );
  }
}
