import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jify_assignment/src/core/bloc/bloc_with_state.dart';
import 'package:jify_assignment/src/domain/entities/image.dart' as im;
import 'package:jify_assignment/src/presentation/blocs/remote_images_bloc.dart';

class GalleryView extends StatelessWidget {
  final _scrollController = ScrollController();
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gallery"),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            controller: _textController,
            onChanged: (value) {
              final remoteImageBloc =
                  BlocProvider.of<RemoteImagesBloc>(context);
              remoteImageBloc.add(GetImages(
                value,
              ));
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              suffixIcon: GestureDetector(
                onTap: () => _onClearTapped(context),
                child: const Icon(Icons.clear),
              ),
              // border: InputBorder.none,
              hintText: 'Enter a search term',
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Expanded(
          child: BlocBuilder<RemoteImagesBloc, RemoteImagesState>(
            builder: (_, state) {
              if (state is RemoteImagesInitial) {
                return const Center(child: Text("Search images"));
              }

              if (state is RemoteImagesEmpty) {
                return  Center(child: Text("${state.message}"));
              }

              if (state is RemoteImagesLoading) {
                return const Center(child: CupertinoActivityIndicator());
              }
              if (state is RemoteImagesError) {
                return Center(child: Text("${state.error.message}"));
              }
              if (state is RemoteImagesDone) {
                return _buildImage(state, context);
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildImage(RemoteImagesDone state, BuildContext context) {
    return ListView.separated(
      controller: _scrollController
        ..addListener(() => _onScrollListener(context)),
      padding: const EdgeInsets.all(16),
      itemCount: calculateListItemCount(state),
      itemBuilder: (context, index) {
        return index >= state.images.length
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: CupertinoActivityIndicator(),
              )
            : ImageListItem(
                image: state.images[index],
              );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 16,
        );
      },
    );
  }

  int calculateListItemCount(RemoteImagesDone state) {
    if (state.noMoreData) {
      return state.images.length;
    } else {
      // + 1 for the loading indicator
      return state.images.length + 1;
    }
  }

  void _onScrollListener(BuildContext context) {
    final remoteImageBloc = BlocProvider.of<RemoteImagesBloc>(context);
    final state = remoteImageBloc.blocProcessState;

    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0 &&
          state == BlocProcessState.idle) {
        remoteImageBloc.add(GetImages(_textController.text, isLoadMore: true));
      }
    }
  }

  void _onClearTapped(BuildContext context) {
    _textController.text = '';
    final remoteImageBloc = BlocProvider.of<RemoteImagesBloc>(context);
    remoteImageBloc.add(GetImages(_textController.text));
  }
}

class ImageListItem extends StatelessWidget {
  final im.Image image;
  ImageListItem({required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: image.previewUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              height: 32,
              decoration: BoxDecoration(
                color: Color(0xFF4C4C4C).withOpacity(0.85),
              ),
              child: Center(
                child: Text(
                  "Total Likes : ${image.likes}     Total Comments : ${image.comments}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
