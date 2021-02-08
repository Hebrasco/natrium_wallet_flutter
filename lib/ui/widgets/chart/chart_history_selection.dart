import 'package:flutter/material.dart';
import 'package:natrium_wallet_flutter/appstate_container.dart';
import 'package:natrium_wallet_flutter/localization.dart';
import 'package:natrium_wallet_flutter/model/chart.dart';

class ChartHistorySelection extends StatefulWidget {
  @override
  ChartHistorySelectionState createState() => ChartHistorySelectionState();
}

class ChartHistorySelectionState extends State<ChartHistorySelection> {
  @override
  Widget build(BuildContext context) => Container(
      height: 50,
      child: ButtonBar(  
        mainAxisSize: MainAxisSize.min,  
        children: getHistoryButtons(context)
    )
  );

   void hisoryButtonPressed(ChartHistoryButtonTypes buttonType) {
    StateContainer.of(context).setState(() {
      StateContainer.of(context).chart.selectedHistoryButton = buttonType;
    });
    StateContainer.of(context).chart.fetchHistoryData(StateContainer.of(context).curCurrency, buttonType);
    StateContainer.of(context).chart.reload();
  }

  bool isHistoryButtonSelected(ChartHistoryButtonTypes buttonType) {
    return buttonType == StateContainer.of(context).chart.selectedHistoryButton;
  }

  String getHistoryButtonName(ChartHistoryButtonTypes buttonType, context) {
    switch (buttonType) {
      case ChartHistoryButtonTypes.TODAY:
        return AppLocalization.of(context).chartToday;
      case ChartHistoryButtonTypes.WEEK:
        return AppLocalization.of(context).chartWeek;
      case ChartHistoryButtonTypes.MONTH:
        return AppLocalization.of(context).chartMonth;
      case ChartHistoryButtonTypes.YEAR:
        return AppLocalization.of(context).chartYear;
      case ChartHistoryButtonTypes.MAX:
        return AppLocalization.of(context).chartMax;
      default:
        return "missing";
    }
  }

  List<Widget> getHistoryButtons(context) {
    List<Widget> historyButtons = [];
    List<ChartHistoryButtonTypes> buttonTypes = [
      ChartHistoryButtonTypes.TODAY,
      ChartHistoryButtonTypes.WEEK,
      ChartHistoryButtonTypes.MONTH,
      ChartHistoryButtonTypes.YEAR,
      ChartHistoryButtonTypes.MAX,
    ];

    for (var buttonType in buttonTypes) {
      historyButtons.add(
      FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100)),
          color: isHistoryButtonSelected(buttonType)
            ? StateContainer.of(context).curTheme.primary15
            : Colors.transparent,
          onPressed: () => hisoryButtonPressed(buttonType), 
          child: Text(
            getHistoryButtonName(buttonType, context),
            style: TextStyle(color: StateContainer.of(context).curTheme.primary),
            ),
          highlightColor:StateContainer.of(context).curTheme.text15,
          splashColor: StateContainer.of(context).curTheme.text30,
        ),
    );
    }
    
    return historyButtons;
  }
}