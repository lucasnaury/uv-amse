// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:media_app/src/screens/about.dart';
import 'package:media_app/src/screens/liked.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'data.dart';
import 'screens/media_details.dart';
import 'screens/medias.dart';
import 'screens/scaffold.dart';
import 'widgets/media_list.dart';

extension GoRouterExtension on GoRouter {
  String location() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();
    return location;
  }
}

final appShellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'app shell');
final mediasNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'medias shell');

class Mediastore extends StatefulWidget {
  final Library libraryInstance;
  const Mediastore({required this.libraryInstance, super.key});

  @override
  State<Mediastore> createState() => _MediastoreState();
}

class _MediastoreState extends State<Mediastore> {
  //Toggle favorite function
  void toggleFav(int id, context) {
    setState(() {
      widget.libraryInstance.toggleFavorite(id);
    });

    bool liked = widget.libraryInstance.allMedias[id].liked;
    // Show an alert dialog when liked
    final snackBar = SnackBar(
      duration: Duration(seconds: 2),
      content: Text(liked ? "Ajouté aux favoris" : "Retiré des favoris"),
      action: SnackBarAction(
        label: 'Annuler',
        onPressed: () {
          setState(() {
            //Revert toggle action when click on "annuler"
            widget.libraryInstance.toggleFavorite(id);
          });
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  int mediaIndex = 0;
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Media app",
      debugShowCheckedModeBanner: false,
      routerConfig: GoRouter(
        debugLogDiagnostics: true,
        initialLocation:
            pageIndex == 0 ? "/medias" : (pageIndex == 1 ? "/liked" : "about"),
        routes: [
          ShellRoute(
            navigatorKey: appShellNavigatorKey,
            builder: (context, state, child) {
              return MediastoreScaffold(
                selectedIndex: switch (state.uri.path) {
                  var p when p.startsWith('/medias') => 0,
                  var p when p.startsWith('/liked') => 1,
                  var p when p.startsWith('/about') => 2,
                  _ => 0,
                },
                child: child,
              );
            },
            routes: [
              // Navigating to the Medias page
              GoRoute(
                path: '/medias',
                builder: (context, state) {
                  pageIndex = 0;
                  return MediasScreen(
                    library: widget.libraryInstance,
                    onTap: (media) =>
                        GoRouter.of(context).push('/medias/info/${media.id}'),
                    toggleFavCallback: (id) => toggleFav(id, context),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'info/:mediaId',
                    parentNavigatorKey: appShellNavigatorKey,
                    builder: (context, state) {
                      return MediaDetailsScreen(
                        media: widget.libraryInstance
                            .getMedia(state.pathParameters['mediaId'] ?? ''),
                      );
                    },
                  ),
                ],
              ),
              // Navigating to the Liked page
              GoRoute(
                path: '/liked',
                builder: (context, state) {
                  pageIndex = 1;
                  return LikedScreen(
                    child: MediaList(
                      medias: widget.libraryInstance.liked,
                      toggleFavCallback: (id) => toggleFav(id, context),
                      onTap: (media) =>
                          GoRouter.of(context).push('/liked/info/${media.id}'),
                    ),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'info/:mediaId',
                    parentNavigatorKey: appShellNavigatorKey,
                    builder: (context, state) {
                      return MediaDetailsScreen(
                        media: widget.libraryInstance
                            .getMedia(state.pathParameters['mediaId'] ?? ''),
                      );
                    },
                  ),
                ],
              ),
              // Navigating to the About page
              GoRoute(
                path: '/about',
                builder: (context, state) {
                  pageIndex = 2;
                  return AboutScreen();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
