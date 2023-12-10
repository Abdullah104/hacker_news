import 'package:flutter_test/flutter_test.dart';

import 'package:http/http.dart' as http;

import 'package:playground/src/article/article.dart';

void main() {
  test('Parses topstories.json', () {
    const jsonString =
        '[32530035,32529412,32529260,32528433,32528769,32530180,32528919,32529908,32524702,32529838,32529884,32528936,32529526,32529457,32519558,32524577,32507659,32496550,32530203,32525245,32497832,32527318,32497194,32524462,32525707,32497782,32526122,32528647,32497844,32529604,32523584,32497179,32526108,32519881,32526047,32528853,32530402,32529398,32527321,32527067,32497193,32519156,32520593,32526255,32497574,32528459,32524007,32525721,32518232,32530286,32522926,32527434,32529952,32524527,32497840,32523067,32521395,32520253,32528842,32519206,32519322,32529575,32526772,32529670,32527694,32529999,32529214,32519346,32528318,32526107,32500572,32520894,32519550,32522466,32513927,32522376,32528378,32507843,32520882,32521159,32529645,32530056,32522911,32522901,32520180,32515474,32521135,32516826,32497493,32517549,32508302,32517402,32521080,32508998,32521556,32524357,32517645,32529614,32528457,32521784,32528840,32491811,32527827,32517342,32507596,32511086,32521586,32524229,32498435,32519918,32526337,32526059,32528270,32527857,32519229,32519547,32509268,32519972,32528893,32526909,32515067,32521139,32520825,32528630,32529113,32494485,32529291,32529763,32517539,32525364,32503692,32517231,32522675,32526136,32529533,32525399,32524880,32517566,32502072,32506027,32508641,32510759,32513651,32521693,32525640,32496462,32507172,32505092,32492514,32528070,32525519,32507041,32529399,32529380,32480919,32518977,32488802,32515515,32525398,32518536,32521703,32513532,32495724,32523832,32513240,32494623,32526425,32523014,32526371,32525560,32500926,32512715,32499298,32517948,32504803,32498225,32509267,32504567,32520645,32525549,32523763,32512918,32525664,32524567,32505560,32514846,32515511,32528335,32507643,32527600,32528658,32495133,32527570,32480740,32506784,32512034,32493549,32510581,32525429,32508082,32493946,32511420,32528225,32494497,32507849,32507147,32485072,32511577,32510262,32515928,32526923,32526819,32508668,32501954,32523948,32480508,32527541,32520932,32486031,32524330,32515111,32513599,32528421,32514793,32526082,32519409,32513020,32520284,32507912,32509189,32503939,32517495,32510405,32508659,32493217,32490455,32523884,32512579,32526276,32511978,32507244,32499371,32506675,32509485,32524828,32511635,32526618,32518791,32527688,32505466,32526893,32524554,32528687,32522952,32527037,32507298,32483979,32514823,32520182,32477195,32508158,32501448,32519947,32525698,32505125,32525686,32525150,32523977,32481533,32510475,32526288,32520042,32505813,32484584,32486504,32479731,32494659,32496915,32493089,32517739,32521452,32498134,32505314,32508818,32512143,32510602,32512576,32523842,32510247,32506627,32497130,32498251,32501993,32526500,32481481,32484008,32521864,32507789,32506168,32520413,32508314,32505633,32499703,32497043,32486133,32526189,32513122,32492436,32511363,32486595,32526510,32492380,32528015,32522750,32485460,32491587,32515546,32497116,32480411,32483695,32484782,32527859,32482523,32491079,32526117,32490736,32494624,32517898,32502511,32518221,32518407,32526624,32501267,32516017,32522732,32513261,32515771,32494923,32487190,32497564,32503183,32507345,32500725,32506207,32503414,32519365,32494200,32494111,32513117,32494244,32495274,32517444,32520801,32525027,32526466,32483846,32502133,32496540,32514055,32491440,32517417,32482034,32517351,32508783,32518722,32522819,32520132,32523289,32490194,32515662,32501557,32496168,32527020,32527015,32526987,32517073,32507069,32498304,32487738,32512950,32504492,32496749,32529366,32491901,32499142,32480054,32506495,32496642,32487430,32510731,32512919,32524849,32485178,32492977,32521609,32494606,32524725,32502321,32484156,32484286,32479968,32500912,32524507,32480009,32509108,32501165,32517920,32523322,32497657,32488308,32500151,32513226,32524068,32490831,32519572,32510830,32488739,32489099,32491050,32490866,32510918,32495227,32490401,32490953,32495896,32521273,32480881,32519616,32518463,32525260,32519825,32519090,32516687,32487856,32511588,32481111,32482563,32484807,32525072,32491973,32508339,32522799,32497225,32496526,32525714,32518089,32512262,32488674,32483077,32482211,32511980,32479659,32487073,32480600,32476262,32479808,32488494,32507243,32489867,32497061,32514377,32483870,32506871,32503051,32490350,32506229,32504463,32476668,32519640,32494454,32523968,32498193,32513420,32497860,32527840,32481340,32512980,32519379,32479888,32507576,32486985,32517937,32514087,32507925,32520503,32520473,32499254,32510033,32482997,32523127,32513143,32482049,32507468,32515533,32484569,32520153,32501731,32489998,32518905,32520069]';

    expect(parseTopStories(jsonString).first, 32530035);
  });

  test('Parses item.json', () {
    const jsonString =
        '{"by":"dhouston","descendants":71,"id":8863,"kids":[9224,8917,8952,8958,8884,8887,8869,8873,8940,8908,9005,9671,9067,9055,8865,8881,8872,8955,10403,8903,8928,9125,8998,8901,8902,8907,8894,8870,8878,8980,8934,8943,8876],"score":104,"time":1175714200,"title":"My YC app: Dropbox - Throw away your USB drive","type":"story","url":"http://www.getdropbox.com/u/2/screencast.html"}';

    expect(parseArticle(jsonString).by, 'dhouston');
  });

  test('Parses item.json over a network', () async {
    const bestStoriesUrl =
        'https://hacker-news.firebaseio.com/v0/beststories.json';
    final bestStoriesResult = await http.get(Uri.parse(bestStoriesUrl));

    if (bestStoriesResult.statusCode == 200) {
      final idList = parseTopStories(bestStoriesResult.body);

      if (idList.isNotEmpty) {
        final storyUrl =
            'https://hacker-news.firebaseio.com/v0/item/${idList.first}.json';

        final storyResult = await http.get(Uri.parse(storyUrl));

        if (storyResult.statusCode == 200) {
          expect(parseArticle(storyResult.body), isNotNull);
        }
      }
    }
  }, skip: true);
}
