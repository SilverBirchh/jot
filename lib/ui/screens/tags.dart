import 'package:Jot/bloc/application/bloc.dart';
import 'package:Jot/bloc/profile/bloc.dart';
import 'package:Jot/data/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Tags extends StatefulWidget {
  @override
  _TagsState createState() => _TagsState();
}

class _TagsState extends State<Tags> {
  final GlobalKey<FormState> _addTagKey = GlobalKey<FormState>();
  List<String> tags;

  @override
  void initState() {
    super.initState();
    tags =
        BlocProvider.of<ApplicationBloc>(context).state.user.tags ?? <String>[];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manage Tags',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffF5C5BE),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTag(),
        child: Icon(Icons.add),
      ),
      body: Container(
        color: Color(0xff539D8B),
        child: Center(
          child: tags.isEmpty
              ? Center(
                  child: Text(
                    'You have no tags...',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : ListView.separated(
                  itemCount: tags.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      indent: 16,
                      endIndent: 16,
                      color: Color(0xffF5C5BE),
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final tag = tags[index];
                    return Container(
                      padding: EdgeInsets.fromLTRB(16, 8, 8, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            tag,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Row(
                            children: <Widget>[
                              IconButton(
                                onPressed: () => _editTag(tag, index),
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    tags.removeAt(index);
                                  });
                                  User user =
                                      BlocProvider.of<ApplicationBloc>(context)
                                          .state
                                          .user;

                                  BlocProvider.of<ApplicationBloc>(context).add(
                                    UpdateUser(
                                      user: user.copyWith(tags: tags),
                                    ),
                                  );

                                  BlocProvider.of<ProfileBloc>(context).add(
                                    UpdateUserProfile(
                                      user.copyWith(tags: tags),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.delete, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }

  Future<void> _editTag(String originalTag, int index) async {
    final TextEditingController _controller =
        TextEditingController(text: originalTag);

    String tag = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Tag Name'),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 26, right: 26, bottom: 16),
              child: Form(
                key: _addTagKey,
                child: TextFormField(
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a tag name';
                    }
                    return null;
                  },
                  controller: _controller,
                  maxLines: 1,
                  autofocus: true,
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, null);
                  },
                  child: const Text('Cancel'),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    if (_addTagKey.currentState.validate()) {
                      Navigator.pop(context, _controller.text);
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            )
          ],
        );
      },
    );

    if (tag == null || tag.isEmpty) {
      return;
    }

    setState(() {
      tags.insert(index, tag);
      tags.removeAt(index + 1);
    });
    User user = BlocProvider.of<ApplicationBloc>(context).state.user;

    BlocProvider.of<ApplicationBloc>(context).add(
      UpdateUser(
        user: user.copyWith(tags: tags),
      ),
    );

    BlocProvider.of<ProfileBloc>(context).add(
      UpdateUserProfile(
        user.copyWith(tags: tags),
      ),
    );
  }

  Future<void> _addTag() async {
    final TextEditingController _controller = TextEditingController();

    String tag = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Tag Name'),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 26, right: 26, bottom: 16),
              child: Form(
                key: _addTagKey,
                child: TextFormField(
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a tag name';
                    }
                    return null;
                  },
                  controller: _controller,
                  maxLines: 1,
                  autofocus: true,
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, null);
                  },
                  child: const Text('Cancel'),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    if (_addTagKey.currentState.validate()) {
                      Navigator.pop(context, _controller.text);
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            )
          ],
        );
      },
    );

    if (tag.isEmpty) {
      return;
    }
    setState(() {
      tags.add(tag);
    });
    User user = BlocProvider.of<ApplicationBloc>(context).state.user;

    BlocProvider.of<ApplicationBloc>(context).add(
      UpdateUser(
        user: user.copyWith(tags: tags),
      ),
    );

    BlocProvider.of<ProfileBloc>(context).add(
      UpdateUserProfile(
        user.copyWith(tags: tags),
      ),
    );
  }
}
