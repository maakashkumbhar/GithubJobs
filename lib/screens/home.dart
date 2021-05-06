import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:githubjobs/models/jobs_model.dart';
import 'package:githubjobs/services/api_services.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Jobs>> _jobs;

  @override
  void initState() {
    _jobs = Api_manager().getJobs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('GitHub Jobs Portal',
              style: GoogleFonts.firaSans(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder<List<Jobs>>(
          future: _jobs,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 3.0,
                      width: double.infinity,
                      child: Card(
                        elevation: 5,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: data.companyLogo == null
                                        ? Image.network(
                                            'https://www.pcgamesn.com/wp-content/uploads/2018/10/discord-logo.jpg')
                                        : Image.network("${data.companyLogo}")),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: SizedBox(
                                  width: 250,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${data.company}",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("${data.createdAt}",
                                          style: TextStyle(
                                            fontSize: 15,
                                          )),
                                      Text("${data.type}",
                                          style: TextStyle(
                                            fontSize: 15,
                                          )),
                                      Text("${data.title}",
                                          style: TextStyle(
                                            fontSize: 15,
                                          )),
                                      Text("${data.location}",
                                          style: TextStyle(
                                            fontSize: 15,
                                          )),
                                      Text("${data.companyUrl}",
                                          style: TextStyle(
                                            fontSize: 15,
                                          )),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
