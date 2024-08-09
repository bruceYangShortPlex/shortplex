import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shortplex/sub/UserInfo/HistoryPage.dart';

import '../../Util/HttpProtocolManager.dart';
import '../../Util/ShortplexTools.dart';
import '../Home/HomeData.dart';

class UsedHistoryPage extends HistoryPage
{
  UsedHistoryPage({super.key, required super.PageTitle, required super.historyType});

  @override
  State<UsedHistoryPage> createState() => _UsedHistoryPageState();
}

class _UsedHistoryPageState extends State<UsedHistoryPage>
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
    HttpProtocolManager.to.Get_WalletHistory(WalletHistoryType.SPEND, _page).then((value)
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
  void initState() {
    widget.loadingComplete = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return widget.HistoryBuild(context);
  }
}
