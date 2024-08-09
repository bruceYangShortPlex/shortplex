import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shortplex/Util/HttpProtocolManager.dart';
import 'package:shortplex/sub/UserInfo/HistoryPage.dart';

import '../../Util/ShortplexTools.dart';
import '../../table/StringTable.dart';
import '../Home/HomeData.dart';

class ChargeHistoryPage extends HistoryPage
{
  ChargeHistoryPage({super.key, required super.PageTitle, required super.historyType});

  @override
  State<ChargeHistoryPage> createState() => _ChargeHistoryPageState();
}

class _ChargeHistoryPageState extends State<ChargeHistoryPage>
{

  void srollControllerInit()
  {
    widget.scrollController.addListener(()
    {
      if (widget.scrollController.position.atEdge)
      {
        bool isTop = widget.scrollController.position.pixels == 0;
        if (!isTop)
        {
          // 스크롤이 끝에 도달했을 때 호출할 함수
          loadMoreItems();
        }
      }
    });
  }

  void loadMoreItems()
  {
    // 추가 아이템을 로드하는 로직을 여기에 작성합니다.
    print('Load more items child');
    if (widget.downCompletePage > widget.maxPage)
    {
      return;
    }

    //testListCreate();

    GetItems(widget.downCompletePage).then((value)
    {
      if (value)
      {
        ++widget.downCompletePage;
      }
    },);
  }

  Future<bool> GetItems(int _page) async
  {
    HttpProtocolManager.to.Get_WalletHistory(_page).then((value)
    {
      if (value == null)
      {
        return;
      }

      widget.maxPage = value.data!.maxPage;

      Map<int,List<HistoryData>> mapData = {};
      for(var item in value.data!.items!)
      {
        var historyData = HistoryData();
        historyData.content1 = item.paymentAmt.isEmpty ? HomeData.to.GetPrice(item.productId!) :  item.paymentAmt;//임시 과거의 값을 알수 없기때문에 서버에서 받아야한다.
        //historyData.content2 = item.description!;
        historyData.title = SetStringArgument(item.description!, [item.credit!]);
        historyData.time = GetReleaseTime(item.createdAt!);
        historyData.iconUrl = HomeData.to.GetShopIcon(item.credit!, false);
        //historyData.episode = 1;
        historyData.createdAt = item.createdAt!;
        historyData.date = '${GetDateString(item.createdAt!).$1} ${GetDateString(item.createdAt!).$2}'; // '5월 2024';

        if (mapData.containsKey(historyData.GetKey()))
        {
          var value = mapData[historyData.GetKey()];
          value?.add(historyData);
        }
        else
        {
          List<HistoryData> list = <HistoryData>[];
          list.add(historyData);
          mapData[historyData.GetKey()] = list;
        }

        if (kDebugMode)
        {
          print('item.productId : ${item.productId!}');
          print('item.description : ${item.description!}');
          print('item.userId : ${item.userId!}');
          print('item.paymentAmt : ${item.paymentAmt}');
        }
      }

      for(var item in mapData.values)
      {
        widget.mainlist.add(item);
      }

      setState(() {
        widget.loadingComplete = true;
      });
    },);

    return false;
  }

  @override
  void initState()
  {
    srollControllerInit();
    super.initState();
    GetItems(widget.downCompletePage);
  }

  testListCreate()
  {
      Map<int,List<HistoryData>> mapData = {};
      for(int i = 0 ; i < 40; ++i)
      {
        var historyData = HistoryData();
        historyData.content1 = '20'; //임시 과거의 값을 알수 없기때문에 서버에서 받아야한다.
        //historyData.content2 = item.description!;
        historyData.title = '테스트';
        historyData.time = GetReleaseTime(DateTime.now().toIso8601String());
        historyData.iconUrl = HomeData.to.GetShopIcon('20', false);
        //historyData.episode = 1;
        historyData.createdAt = DateTime.now().toIso8601String();
        historyData.date = '${GetDateString(DateTime.now().toIso8601String()).$1} ${GetDateString(DateTime.now().toIso8601String()).$2}'; // '5월 2024';

        if (mapData.containsKey(historyData.GetKey()))
        {
          var value = mapData[historyData.GetKey()];
          value?.add(historyData);
          mapData[historyData.GetKey()] = value!;
        }
        else
        {
          List<HistoryData> list = <HistoryData>[];
          list.add(historyData);
          mapData[historyData.GetKey()] = list;
        }
      }

      try
      {
        print(1);

        for (var item in mapData.values)
        {
          print(item);
          widget.mainlist.add(item);
        }

        print(2);
      }
      catch(e)
    {
      print(' item add fail $e');
    }

      setState(() {
        widget.loadingComplete = true;
      });

      // WidgetsBinding.instance.addPostFrameCallback((_)
      // {
      //   if (mounted) {
      //     setState(() {
      //       widget.loadingComplete = true;
      //     });
      //   }
      // });
  }

  @override
  Widget build(BuildContext context)
  {
    return widget.HistoryBuild(context);
  }
}
