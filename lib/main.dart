import 'package:flutter/material.dart';  
import 'package:flutter/foundation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /* 
            Putting a Column inside an Expanded widget stretches the column
            to use all remaining free space in the row. Setting the crossAxisAlignment
            to CrossAxisAlignment.start positions the column at start of the row.
            */
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*
                Putting the first row of text inside a Container enables you to add padding.
                The second child in the Column, also text, displays as grey.
                */
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Oeschinen Lake Campground',
                    style: TextStyle(fontWeight: FontWeight.bold)
                  ),
                ),
                Text(
                  'Kanderstag, Switzelrand',
                  style: TextStyle(color: Colors.grey[500])
                )
              ]
            ),
          ),
          /*
          The last two items in the title row are a star icon, painted red, and the text '41'.
          The entire row is in a Container and padded along each edge by 32 pixels.
          */
          FavoriteWidget()
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.call , 'CALL'),
          _buildButtonColumn(color, Icons.near_me, 'Route'),
          _buildButtonColumn(color, Icons.share, 'SHAARE'),
        ],
      ),
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),

      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
        'Alps. Situated 1,578 meters above sea level, it is one of the '
        'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
        'half-hour walk through pastures and pine forest, leads you to the '
        'lake, which warms to 20 degrees Celsius in the summer. Activities '
        'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
    );

    return MaterialApp(
      title: 'Flutter Layout Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('Layout Demo Home Page'),),

        body: ListView(
          children: [
            Image.asset(
              'images/lake.jpg',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            titleSection,
            buttonSection,
            textSection,
          // Managing state part of the tutorial
          TapboxA(),
          // TapboxB(),
          ParentBWidget(),
          // TapboxC(),
          ParentCWidget(),
          ],
        )
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            )
          ),
        )
      ],
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  @override _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  @override Widget build(BuildContext context) {

    void _toggleFavorite() {
      setState(() {
       if (_isFavorited) {
         _favoriteCount -= 1;
         _isFavorited = false;
       } else {
         _favoriteCount += 1;
         _isFavorited = true;
       }
      });
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
            color: Colors.red,
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
          width: 18,
          child: Container(
            child: Text('$_favoriteCount'),
          ),
        )
      ],
    );
  }
}

//------------------------- TapboxA ----------------------------------
class TapboxA extends StatefulWidget {
  TapboxA({Key key}) : super(key: key);
  @override _TapboxAState createState() => _TapboxAState();
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
     _active = !_active; 
    });
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            _active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        height: 200.0,
        decoration: BoxDecoration(
          color: _active ? Colors.lightBlue[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

//----------------------- TapboxB ParentWidget ------------------------
class ParentBWidget extends StatefulWidget {
  @override _ParentBWidgetState createState() => _ParentBWidgetState();
}

class _ParentBWidgetState extends State<ParentBWidget> {
  bool _active = false;

  void _handleTapboxBChanged(bool newValue) {
    setState(() {
     _active = newValue; 
    });
  }

  @override Widget build(BuildContext context) {
    return Container(
      child: TapboxB(
        active: _active,
        onChanged: _handleTapboxBChanged,
      ),
    );
  }
}

//------------------------- TapboxB ----------------------------------
class TapboxB extends StatelessWidget {
  TapboxB({Key key, this.active: false, @required this.onChanged}) : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  Widget build(BuildContext c) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.2, color: Colors.pink),
          ),
        ),
        height: 200.0,
        decoration: BoxDecoration(
          color: active ? Colors.lightBlue[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

//------------------------- TapboxC ParentWidget ---------------------
class ParentCWidget extends StatefulWidget {
  @override _ParentCWidgetState createState() => _ParentCWidgetState();
}

class _ParentCWidgetState extends State<ParentCWidget> {
  bool _active = false;

  void _handleTapboxCChanged(bool newValue) {
    setState(() {
     _active = newValue; 
    });
  }

  @override Widget build(BuildContext c) {
    return Container(
      child: TapboxC(
        active: _active,
        onChanged: _handleTapboxCChanged,
      )
    );
  }
}
//------------------------- TapboxC ----------------------------------
class TapboxC extends StatefulWidget {
  TapboxC({Key key, this.active: false, @required this.onChanged}) : super (key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  _TapboxCState createState() => _TapboxCState();
}

class _TapboxCState extends State<TapboxC> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails d) {
    setState(() {
     _highlight = true; 
    });
  }

  void _handleTapUp(TapUpDetails d) {
    setState(() {
     _highlight = false; 
    });
  }

  void _handleTapCancel() {
    _highlight = false;
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  Widget build(BuildContext c) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: Container(
        child: Center(
          child: Text(
            widget.active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        height: 200.0,
        decoration: BoxDecoration(
          color: widget.active ? Colors.lightBlue[700] : Colors.grey[600],
          border: _highlight ? Border.all(color: Colors.teal[700], width: 10.0)
                              : null,
        ),
      ),
    );
  }
}