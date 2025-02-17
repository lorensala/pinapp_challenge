// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$commentsNotifierHash() => r'e640be63d969cd56b5745e05b24fd67c105c644a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$CommentsNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<Comment>> {
  late final int postId;

  FutureOr<List<Comment>> build({
    required int postId,
  });
}

/// See also [CommentsNotifier].
@ProviderFor(CommentsNotifier)
const commentsNotifierProvider = CommentsNotifierFamily();

/// See also [CommentsNotifier].
class CommentsNotifierFamily extends Family<AsyncValue<List<Comment>>> {
  /// See also [CommentsNotifier].
  const CommentsNotifierFamily();

  /// See also [CommentsNotifier].
  CommentsNotifierProvider call({
    required int postId,
  }) {
    return CommentsNotifierProvider(
      postId: postId,
    );
  }

  @override
  CommentsNotifierProvider getProviderOverride(
    covariant CommentsNotifierProvider provider,
  ) {
    return call(
      postId: provider.postId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'commentsNotifierProvider';
}

/// See also [CommentsNotifier].
class CommentsNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    CommentsNotifier, List<Comment>> {
  /// See also [CommentsNotifier].
  CommentsNotifierProvider({
    required int postId,
  }) : this._internal(
          () => CommentsNotifier()..postId = postId,
          from: commentsNotifierProvider,
          name: r'commentsNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$commentsNotifierHash,
          dependencies: CommentsNotifierFamily._dependencies,
          allTransitiveDependencies:
              CommentsNotifierFamily._allTransitiveDependencies,
          postId: postId,
        );

  CommentsNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.postId,
  }) : super.internal();

  final int postId;

  @override
  FutureOr<List<Comment>> runNotifierBuild(
    covariant CommentsNotifier notifier,
  ) {
    return notifier.build(
      postId: postId,
    );
  }

  @override
  Override overrideWith(CommentsNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: CommentsNotifierProvider._internal(
        () => create()..postId = postId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        postId: postId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CommentsNotifier, List<Comment>>
      createElement() {
    return _CommentsNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CommentsNotifierProvider && other.postId == postId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CommentsNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<List<Comment>> {
  /// The parameter `postId` of this provider.
  int get postId;
}

class _CommentsNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CommentsNotifier,
        List<Comment>> with CommentsNotifierRef {
  _CommentsNotifierProviderElement(super.provider);

  @override
  int get postId => (origin as CommentsNotifierProvider).postId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
