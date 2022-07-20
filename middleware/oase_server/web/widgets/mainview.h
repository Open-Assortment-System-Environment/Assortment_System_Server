#ifndef MAINVIEW_H
#define MAINVIEW_H

#include "containerwidget.h"

#include <Wt/WAnchor.h>
#include <Wt/WCheckBox.h>
#include <Wt/WContainerWidget.h>
#include <Wt/WDialog.h>
#include <Wt/WEnvironment.h>
#include <Wt/WImage.h>
#include <Wt/WLineEdit.h>
#include <Wt/WLogger.h>
#include <Wt/WMessageBox.h>
#include <Wt/WPushButton.h>
#include <Wt/WText.h>
#include <Wt/WTheme.h>
#include <Wt/WImage.h>
#include <Wt/WLink.h>

class MainView : public ContainerWidget
{
public:
    MainView();
    // show functions:
    void showTex1();
    void showTex2();

private:
    Wt::WCheckBox *tex1_;
    Wt::WCheckBox *tex2_;
    std::unique_ptr<Wt::WCheckBox> tex1_ptr;
    std::unique_ptr<Wt::WCheckBox> tex2_ptr;
    bool state2_;


    // widget manigment functions:
    void hideAll();

    // init functions:
    std::unique_ptr<Wt::WCheckBox> initTex1();
    std::unique_ptr<Wt::WCheckBox> initTex2();

};

#endif // MAINVIEW_H
