import 'package:flutter/material.dart';
import 'package:flutter_webview/model/signer/signer_data_obj.dart';
import 'package:sticky_headers/sticky_headers.dart';

class SignerInfoView extends StatelessWidget {
  const SignerInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> headerList = [
      "Signer Information",
      "Issuer Information",
      "Validity Period"
    ];
    SignerDataObj signerDataObj = SignerDataObj(
        "Pertrin Li \nplee@nexify.com.hk \nOffice of the Gvernment \nHong Kong SAR Govemment \nHong Kong ABC Certificate Authority e-Cert\nHK",
        "Hong Kong ABC Certificate Authority e-Cert 3 - 18\nHong Kong ABC Certificate Authority e-Cert \nHong Kong \nHong Kong\nHK",
        DateTime(2020, 5, 5),
        DateTime(2020, 5, 5));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Signer Info'),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: headerList.length,
        itemBuilder: (context, index) {
          return StickyHeaderBuilder(
              builder: (BuildContext context, double stuckAmount) {
                return Container(
                  height: 50.0,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    headerList[index],
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
              content: addInfoItem(index, signerDataObj));
        },
      ),
    );
  }

  Widget addInfoItem(int index, SignerDataObj signerDataObj) {
    if (index == 0) {
      return Column(children: [
        InfoListItem(title: "Subject DN:", content: signerDataObj.subjectDN)
      ]);
    } else if (index == 1) {
      return Column(
        children: [
        InfoListItem(title: "Issuer DN:", content: signerDataObj.issuerDN)
      ]);
    } else {
      return Column(children: [
        InfoListItem(
            title: "Validity From:",
            content: signerDataObj.validityFrom.toString()),
        InfoListItem(
            title: "Validity To:", content: signerDataObj.validityTo.toString())
      ]);
    }
  }
}

class InfoListItem extends StatelessWidget {
  const InfoListItem({super.key, required this.title, required this.content});

  final String content;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 5.0, 10.0, 5.0),
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1,child: Text(title,style: const TextStyle(fontWeight: FontWeight.bold),)),
            Expanded(flex: 3, child: Text(content)),
          ],
        ),
      ),
    );
  }
}
