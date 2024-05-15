import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../proj_provider/like_provider.dart';

class CustomCard extends StatefulWidget {

  final String title;
  final String subtitle;
  final String imageUrl;
  final String description;

  const CustomCard({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.description,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {

  bool isLiked = false;
  bool isDropdownOpen = false;
  bool isDropdownOpen1 = false;

  @override
  Widget build(BuildContext context) {
    final likedCardsProvider = Provider.of<LikedCardsProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.circle, color: Colors.red, size: 56.0),
                          SizedBox(width: 8.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(widget.subtitle,style: TextStyle(fontSize: 12),),
                            ],
                          ),
                          Spacer(),
                          PopupMenuButton<String>(
                            color: Colors.white,
                            icon: Icon(Icons.more_horiz),
                            onSelected: (value) {
                              if (value == 'Save') {
                                // Perform share action
                              }
                            },
                            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'Save',
                                child: Row(
                                  children: [
                                    Icon(Icons.class_outlined),
                                    SizedBox(width: 8.0),
                                    Text('Save'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Image(
                        image: NetworkImage(widget.imageUrl),
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 12.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                              textAlign: TextAlign.justify,
                            TextSpan(
                              children: [
                                if (!isDropdownOpen1)
                                  TextSpan(
                                    text: widget.description.split(' ').take(10).join(' ') + '...',
                                    style: TextStyle(fontSize: 16.0,),
                                  ),
                                if (!isDropdownOpen1)
                                  TextSpan(
                                    text: ' See more',
                                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        setState(() {
                                          isDropdownOpen1 = !isDropdownOpen1;
                                        });
                                      },
                                  ),
                                if (isDropdownOpen1)
                                  TextSpan(
                                    text: widget.description,
                                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                                  ),
                                if (isDropdownOpen1)
                                  TextSpan(
                                    text: ' See less',
                                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        setState(() {
                                          isDropdownOpen1 = !isDropdownOpen1;
                                        });
                                      },
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Divider(),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isLiked = !isLiked;
                                if (isLiked) {
                                  likedCardsProvider.addLikedCard(
                                    widget.title,
                                    widget.subtitle,
                                    widget.imageUrl,
                                    widget.description,
                                  );
                                } else {
                                  likedCardsProvider.removeLikedCard(
                                    widget.title,
                                    widget.subtitle,
                                    widget.imageUrl,
                                    widget.description,
                                  );
                                }
                              });
                            },
                            child: Icon(
                              isLiked ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                              color: isLiked ? Colors.red : Colors.grey,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Text('5k Like'),
                          Spacer(),
                          Icon(Icons.comment_outlined, color: Colors.grey),
                          SizedBox(width: 8.0),
                          Text('45 Comment'),
                          Spacer(),
                          Icon(Icons.share, color: Colors.grey),
                          SizedBox(width: 8.0),
                          Text('Share'),
                        ],
                      ),
                      if (isDropdownOpen)
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                },
                                child: Text(
                                  'Share',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
    );
  }
}