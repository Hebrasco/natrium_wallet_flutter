import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:natrium_wallet_flutter/appstate_container.dart';
import 'package:natrium_wallet_flutter/localization.dart';
import 'package:natrium_wallet_flutter/ui/widgets/chart/chart_data.dart';
import 'package:natrium_wallet_flutter/ui/widgets/chart/chart_titles.dart';
import 'package:natrium_wallet_flutter/ui/widgets/chart/chart_touch_data.dart';

enum HistoryButtonType {
  TODAY,
  WEEK,
  MONTH,
  YEAR,
  MAX
}

class PriceChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(children: [
    Chart(context),
    HistorySelection(context),
  ]);

  Widget Chart(context) {
    return Container(
      height: 350,
      width: MediaQuery.of(context).size.width,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: 13,
          minY: 0,
          maxY: 10,
          titlesData: PriceChartTitles.getTitleData(context),
          gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: StateContainer.of(context).curTheme.background,
                strokeWidth: 1,
              );
            },
            drawVerticalLine: false,
          ),
          borderData: FlBorderData(
            show: false,
          ),
          lineBarsData: [PriceChartData.getChartData(context)],
          lineTouchData: PriceChartTouchData.getTouchData(context),
        ),
      ),
    );
  }

  Widget HistorySelection(context) {
    HistoryButtonType selectedHistoryButton = HistoryButtonType.TODAY;

    void hisoryButtonPressed(HistoryButtonType buttonType) {
      print(buttonType);
      switch (buttonType) {
        case HistoryButtonType.TODAY:
          break;
        case HistoryButtonType.WEEK:
          break;
        case HistoryButtonType.MONTH:
          break;
        case HistoryButtonType.YEAR:
          break;
        case HistoryButtonType.MAX:
          break;
      }
    }

    bool isHistoryButtonSelected(HistoryButtonType buttonType) {
      return buttonType == selectedHistoryButton;
    }

    List<Widget> getHistoryButtons() {
      List<Widget> historyButtons = [];
      List<HistoryButtonType> buttonTypes = [
        HistoryButtonType.TODAY,
        HistoryButtonType.WEEK,
        HistoryButtonType.MONTH,
        HistoryButtonType.YEAR,
        HistoryButtonType.MAX,
      ];

      for (var button in buttonTypes) {
        historyButtons.add(
        FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            color: isHistoryButtonSelected(button)
              ? StateContainer.of(context).curTheme.primary30
              : Colors.transparent,
            onPressed: () => hisoryButtonPressed(button), 
            child: Text(
              "Today", // AppLocalization.of(context).receive, // TODO: Localize Strings
              style: TextStyle(color: StateContainer.of(context).curTheme.primary),
              ),
            highlightColor:StateContainer.of(context).curTheme.text15,
            splashColor: StateContainer.of(context).curTheme.text30,
          ),
      );
      }
      
      return historyButtons;
    }

    return Container(
      height: 50,
      child: ButtonBar(  
        mainAxisSize: MainAxisSize.min,  
        children: getHistoryButtons()
      ) 
    );
  }
}