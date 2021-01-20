import 'package:flutter/material.dart';
import 'package:natrium_wallet_flutter/appstate_container.dart';
import 'package:natrium_wallet_flutter/localization.dart';

enum HistoryButtonType {
  TODAY,
  WEEK,
  MONTH,
  YEAR,
  MAX
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

    String getHistoryButtonName(HistoryButtonType buttonType) {
      switch (buttonType) {
        case HistoryButtonType.TODAY:
          return AppLocalization.of(context).chartToday;
        case HistoryButtonType.WEEK:
          return AppLocalization.of(context).chartWeek;
        case HistoryButtonType.MONTH:
          return AppLocalization.of(context).chartMonth;
        case HistoryButtonType.YEAR:
          return AppLocalization.of(context).chartYear;
        case HistoryButtonType.MAX:
          return AppLocalization.of(context).chartMax;
        default:
          return "missing";
      }
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

      for (var buttonType in buttonTypes) {
        historyButtons.add(
        FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            color: isHistoryButtonSelected(buttonType)
              ? StateContainer.of(context).curTheme.primary30
              : Colors.transparent,
            onPressed: () => hisoryButtonPressed(buttonType), 
            child: Text(
              getHistoryButtonName(buttonType),
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