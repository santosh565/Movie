import 'package:flutter/material.dart';
import 'package:movie_app/model/movie.dart';

void main() => runApp(MovieListView());

class MovieListView extends StatefulWidget {
  @override
  _MovieListViewState createState() => _MovieListViewState();
}

class _MovieListViewState extends State<MovieListView> {
  final List<Movie> movieList = Movie.getMovies();

  /* final List movies = [
    'Extraction',
    'Snowpiercer',
    'Flowers of War',
    'Infiltrator',
    'Pandit Baje ko Lauri',
    'Guilty',
    'Spencer Confidential',
    'Avatar',
    '300',
    'Titanic',
    'Loot',
    'Dabangg',
    'Rang de Basanti',
  ]; */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Text('Movies'),
          backgroundColor: Colors.blueGrey[800],
        ),
        body: SafeArea(
          child: ListView.builder(
            itemCount: movieList.length,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              return Stack(
                children: <Widget>[
                  movieCard(movieList[index], context),
                  Positioned(
                    top: 10.0,
                    left: 5.0,
                    child: movieImage(
                      movieList[index].images[0],
                    ),
                  ),
                ],
              );
              // card
              /* return Card(
                elevation: 4.5,
                color: Colors.white,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      movieList[index].images[0],
                    ),
                    radius: 29.0,
                  ),
                  title: Text(
                    '${movieList[index].title}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text('${movieList[index].type}'),
                  trailing: Icon(Icons.more_horiz),
                  /* onTap: () => debugPrint(
                    'onTapped:${movies[index]}',
                  ), */
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieListViewDetails(
                        movie: movieList[index],
                      ),
                    ),
                  ),
                ),
              ); */
            },
          ),
        ),
      ),
    );
  }

  Widget movieCard(Movie movie, BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieListViewDetails(
            movie: movie,
          ),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(
          left: 50.0,
        ),
        /* width: MediaQuery.of(context).size.width, */ // enabling this limits the width of card widget in landscape mode//
        height: 120.0,
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 54.0,
              top: 8.0,
              bottom: 8.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        movie.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                    Text(
                      'Rating:${movie.imdbRating}/10      ',
                      style: textStyle(),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      movie.released,
                      style: textStyle(),
                    ),
                    Text(
                      movie.runtime,
                      style: textStyle(),
                    ),
                    Text(
                      '${movie.rated}      ',
                      style: textStyle(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle textStyle() {
    return TextStyle(
      fontSize: 14.0,
    );
  }

  Widget movieImage(String imageUrl) {
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(
          4.0,
        ),
        image: DecorationImage(
          image: NetworkImage(imageUrl ??
              'https://images-na.ssl-images-amazon.com/images/M/MV5BMTc0NzAxODAyMl5BMl5BanBnXkFtZTgwMDg0MzQ4MDE@._V1_SX1500_CR0,0,1500,999_AL_.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class MovieListViewDetails extends StatelessWidget {
  final Movie movie;

  const MovieListViewDetails({Key key, this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        title: Text('${movie.title}'),
      ),
      backgroundColor: Colors.blueGrey,
      body: ListView(
        children: <Widget>[
          MovieDetailsThumbnail(
            thumbnail: movie.images[0],
          ),
          MovieDetailsHeaderWithPoster(
            movie: movie,
          ),
          Divider(
            color: Colors.white,
            indent: 8,
            endIndent: 8,
          ),
          MovieDetailsCast(
            movie: movie,
          ),
          Divider(
            color: Colors.white,
            indent: 8,
            endIndent: 8,
          ),
          MovieDetailsExtraPosters(
            posters: movie.images,
          ),
        ],
      ),
      /*  body: Center(
        child: Container(
          child: RaisedButton(
            child: Text('${movie.director}'),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ), */
    );
  }
}

class MovieDetailsThumbnail extends StatelessWidget {
  final String thumbnail;

  const MovieDetailsThumbnail({Key key, this.thumbnail}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: 200.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                thumbnail,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Icon(
            Icons.play_circle_outline,
            size: 50.0,
            color: Colors.white,
          ),
        ),
        Container(
          height: 50.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.blueGrey[900],
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }
}

class MovieDetailsHeaderWithPoster extends StatelessWidget {
  final Movie movie;

  const MovieDetailsHeaderWithPoster({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5, top: 5),
      child: Row(
        children: <Widget>[
          MoviePoster(
            poster: movie.images[0].toString(),
          ),
          SizedBox(width: 10),
          Expanded(
            child: MovieDetailsHeader(
              movie: movie,
            ),
          ),
        ],
      ),
    );
  }
}

/* Widget moviePoster (BuildContext context,String poster){

  return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(poster),
            fit: BoxFit.cover,
          ),
        ),
        width: MediaQuery.of(context).size.width / 3.5,
        height: 140,
      ),
    );

} */

class MoviePoster extends StatelessWidget {
  final String poster;

  const MoviePoster({Key key, this.poster}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(poster),
            fit: BoxFit.cover,
          ),
        ),
        width: MediaQuery.of(context).size.width / 3.5,
        height: 140,
      ),
    );
  }
}

class MovieDetailsHeader extends StatelessWidget {
  final Movie movie;

  const MovieDetailsHeader({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10),
      alignment: Alignment.center,
      height: 140,
      child: ListView(
        children: <Widget>[
          Text(
            '${movie.year}  . ${movie.genre}'.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            movie.title,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text.rich(
            TextSpan(
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: movie.plot,
                ),
                TextSpan(
                  text: 'more...',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MovieDetailsCast extends StatelessWidget {
  final Movie movie;

  const MovieDetailsCast({Key key, this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
      ),
      child: Column(
        children: <Widget>[
          MovieField(field: 'Cast', value: movie.actors),
          MovieField(field: 'Director', value: movie.director),
          MovieField(field: 'Awards', value: movie.awards),
        ],
      ),
    );
  }
}

class MovieField extends StatelessWidget {
  final String field;
  final String value;

  const MovieField({Key key, this.field, this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$field :  ',
          style: TextStyle(
            color: Colors.white38,
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
        )
      ],
    );
  }
}

class MovieDetailsExtraPosters extends StatelessWidget {
  final List<String> posters;

  const MovieDetailsExtraPosters({Key key, this.posters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: EdgeInsets.only(
        bottom: 8,
        left: 8,
        right: 8,
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(
          width: 8,
        ),
        itemCount: posters.length,
        itemBuilder: (context, index) => Container(
          width: MediaQuery.of(context).size.width / 4,
          /*  height: 160, */
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(posters[index]),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
