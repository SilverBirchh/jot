import 'package:Jot/bloc/application/application_bloc.dart';
import 'package:Jot/bloc/profile/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<ScaffoldState> _feedbackKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (BuildContext context, ProfileState state) {
        if (state is SentFeedback) {
          _controller.text = '';
          const SnackBar snackBar = SnackBar(
            content: Text('Thank you! We have received your feedback'),
          );
          _feedbackKey.currentState.hideCurrentSnackBar();
          _feedbackKey.currentState.showSnackBar(snackBar);
        } else if (state is FeedbackError) {
          const SnackBar snackBar = SnackBar(
            content: Text(
                'Hmm there was a problem sending your feedback. Please try again.'),
          );
          _feedbackKey.currentState.hideCurrentSnackBar();
          _feedbackKey.currentState.showSnackBar(snackBar);
        }
      },
      child: Scaffold(
        key: _feedbackKey,
        appBar: AppBar(
          title: const Text('Feedback'),
          centerTitle: true,
          backgroundColor: Color(0xff2ebf91),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                if (_controller.text.isEmpty) {
                  const SnackBar snackBar =
                      SnackBar(content: Text('Please enter some feedback'));
                  _feedbackKey.currentState.showSnackBar(snackBar);
                  return;
                }
                final String userId =
                    BlocProvider.of<ApplicationBloc>(context).state.user.uid;
                BlocProvider.of<ProfileBloc>(context)
                    .add(SubmitFeedback(_controller.text, userId));
              },
              icon: Icon(Icons.send),
            )
          ],
        ),
        body: Container(
          margin: const EdgeInsets.all(16),
          child: TextField(
            expands: true,
            decoration: InputDecoration(
              hintText: 'Add feedback...',
              border: InputBorder.none,
            ),
            controller: _controller,
            textCapitalization: TextCapitalization.sentences,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            autofocus: true,
          ),
        ),
      ),
    );
  }
}
