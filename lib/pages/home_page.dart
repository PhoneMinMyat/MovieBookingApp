import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:movie_booking_app/bloc/home_bloc.dart';
import 'package:movie_booking_app/data/models/the_move_db_model.dart';
import 'package:movie_booking_app/data/models/the_move_db_model_impl.dart';
import 'package:movie_booking_app/data/models/tmba_model.dart';
import 'package:movie_booking_app/data/models/tmba_model_impl.dart';
import 'package:movie_booking_app/data/vos/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo.dart';
import 'package:movie_booking_app/data/vos/profile_vo.dart';
import 'package:movie_booking_app/dummy_data.dart';
import 'package:movie_booking_app/pages/movie_detail_page.dart';
import 'package:movie_booking_app/pages/welcome_page.dart';
import 'package:movie_booking_app/resources/color.dart';

import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/string.dart';
import 'package:movie_booking_app/viewitems/movielist_items.dart';
import 'package:movie_booking_app/widgets/title_text.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void logOut(HomeBloc bloc) {
    bloc.tabLogOut().then((success) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const WelcomePage(),
          ),
          (Route<dynamic> route) => false);
    }).catchError((error) {});
  }

  void navigationToMovieDetailPage(BuildContext context, int? movieId) {
    if (movieId != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MovieDetailPage(
                    movieId: movieId,
                  )));
    }
  }

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeBloc(),
      child: Selector<HomeBloc, ProfileVO?>(
        selector: (context, bloc) => bloc.profile,
        builder: (context, profile, child) => Scaffold(
          key: _scaffoldKey,
          appBar: HomePageAppBar(() {
            openDrawer();
          }),
          drawer: MenuDrawerSection(
            () {
              HomeBloc bloc = Provider.of<HomeBloc>(context, listen: false);
              logOut(bloc);
            },
            profile: profile ?? ProfileVO(),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileSectionView(
                  name: profile?.name ?? '',
                ),
                const SizedBox(
                  height: MARGIN_MEDIUM_3x,
                ),
                Selector<HomeBloc, List<MovieVO>?>(
                  selector: (context, bloc) => bloc.nowPlayingMovieList,
                  builder: (context, nowPlayingMovieList, child) =>
                      HorizontalMovieListView(
                    (movieId) {
                      navigationToMovieDetailPage(context, movieId);
                    },
                    headerText: HOMEPAGE_NOW_SHOWING_TEXT,
                    movieList: nowPlayingMovieList ?? [],
                  ),
                ),
                const SizedBox(
                  height: MARGIN_MEDIUM_3x,
                ),
                Selector<HomeBloc, List<MovieVO>?>(
                  selector: (context, bloc) => bloc.upcomingMovieList,
                  builder: (context, upcomingMovieList, child) =>
                      HorizontalMovieListView(
                    (movieId) {
                      navigationToMovieDetailPage(context, movieId);
                    },
                    headerText: HOMEPAGE_COMING_SOON_TEXT,
                    movieList: upcomingMovieList ?? [],
                  ),
                ),
                const SizedBox(
                  height: MARGIN_MEDIUM_3x,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuDrawerSection extends StatelessWidget {
  final Function tapLogout;
  final ProfileVO profile;
  const MenuDrawerSection(
    this.tapLogout, {
    required this.profile,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: PRIMARY_COLOR,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2x),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: MARGIN_XXLARGE * 2,
            ),
            DrawerUserInfoSectionView(
              name: profile.name ?? '',
              email: profile.email ?? '',
            ),
            const SizedBox(
              height: MARGIN_XXLARGE,
            ),
            Column(
              children: menuList
                  .map((menuItem) =>
                      IconAndTextView(iconData: menuItem[0], text: menuItem[1]))
                  .toList(),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                tapLogout();
              },
              child: const IconAndTextView(
                  iconData: MdiIcons.logoutVariant, text: DRAWER_LOG_OUT),
            )
          ],
        ),
      ),
    );
  }
}

class IconAndTextView extends StatelessWidget {
  final IconData iconData;
  final String text;
  const IconAndTextView({
    required this.iconData,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            iconData,
            color: Colors.white,
          ),
          title: Text(
            text,
            style: const TextStyle(
              fontSize: TEXT_REGULAR,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2x,
        )
      ],
    );
  }
}

class DrawerUserInfoSectionView extends StatelessWidget {
  final String name;
  final String email;
  const DrawerUserInfoSectionView({
    required this.name,
    required this.email,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const ProfilePicView(
          isElevation: true,
        ),
        const SizedBox(
          width: MARGIN_MEDIUM,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: TEXT_REGULAR_2x),
            ),
            const SizedBox(
              height: MARGIN_SMALL,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    email,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: DRAWER_GMAIL_FONT_SIZE),
                  ),
                ),
                const SizedBox(
                  width: MARGIN_MEDIUM_3x,
                ),
                const Text(
                  DRAWER_EDIT,
                  style: TextStyle(
                      color: Colors.white, fontSize: DRAWER_GMAIL_FONT_SIZE),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  final String headerText;
  final Function(int?) onTap;
  final List<MovieVO> movieList;
  const HorizontalMovieListView(
    this.onTap, {
    required this.headerText,
    required this.movieList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2x),
          child: TitleText(headerText),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2x,
        ),
        SizedBox(
          height: HORIZONTAL_MOVIE_LIST_HEIGHT,
          child: ListView.builder(
              padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2x),
              scrollDirection: Axis.horizontal,
              itemCount: movieList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () => onTap(movieList[index].id),
                    child: HorizontalMovieListItem(
                      movie: movieList[index],
                    ));
              }),
        ),
      ],
    );
  }
}

class ProfileSectionView extends StatelessWidget {
  final String name;
  const ProfileSectionView({
    required this.name,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2x),
          child: ProfilePicView(),
        ),
        const SizedBox(width: MARGIN_SMALL),
        Text(
          'Hi $name!',
          style: const TextStyle(
              fontSize: TEXT_HEADING_2X, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class ProfilePicView extends StatelessWidget {
  final bool isElevation;
  const ProfilePicView({
    this.isElevation = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MARGIN_XXLARGE,
      width: MARGIN_XXLARGE,
      decoration: BoxDecoration(
        boxShadow: (isElevation)
            ? [
                const BoxShadow(
                  color: Colors.black38,
                  blurRadius: 3,
                  offset: Offset(0.0, 3.0),
                ),
              ]
            : null,
        shape: BoxShape.circle,
        image: const DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                'https://images.generated.photos/Rh2BAh5lK4GwuKDW01hHlB8DfGIQVdRaCTahZ1FF8dI/rs:fit:256:256/czM6Ly9pY29uczgu/Z3Bob3Rvcy1wcm9k/LnBob3Rvcy92M18w/MDUyMDU5LmpwZw.jpg')),
      ),
    );
  }
}

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function tapMenuDrawer;
  const HomePageAppBar(
    this.tapMenuDrawer, {
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(MARGIN_MEDIUM_2x),
        child: MenuDrawerButtonView(() {
          tapMenuDrawer();
        }),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: MARGIN_MEDIUM_2x),
          child: SearchIconButtonView(),
        )
      ],
    );
  }
}

class SearchIconButtonView extends StatelessWidget {
  const SearchIconButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.search,
      color: Colors.black,
      size: HOMEPAGE_SEARCH_ICON_SIZE,
    );
  }
}

class MenuDrawerButtonView extends StatelessWidget {
  final Function onTapMenu;
  const MenuDrawerButtonView(
    this.onTapMenu, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapMenu();
      },
      child: Image.asset(
        'assets/images/drawer_icon.png',
      ),
    );
  }
}
