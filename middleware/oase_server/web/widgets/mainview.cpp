#include "mainview.h"

MainView::MainView()
{
    tex1_ = this->addWidget(initTex1());
    state2_ = false;
}

void MainView::hideAll()
{
    tex1_->hide();
    tex2_->hide();
    tex1_->disable();
    tex2_->disable();
}

std::unique_ptr<Wt::WCheckBox> MainView::initTex1()
{
    return std::make_unique<Wt::WCheckBox>("Tex1");
    //tex1_ = this->addWidget(std::make_unique<Wt::WCheckBox>("Tex1"));
    //tex1_->hide();
}

std::unique_ptr<Wt::WCheckBox> MainView::initTex2()
{
    return std::make_unique<Wt::WCheckBox>("Tex2");
    //tex2_ = this->addWidget(std::make_unique<Wt::WCheckBox>("Tex2"));
    //tex2_->hide();
}

void MainView::showTex1()
{
    if(state2_)
    {
        this->clear();
        this->addWidget(initTex1());
        state2_ = false;
    }
    //hideAll();
    //tex1_->enable();
    //tex1_->show();
}

void MainView::showTex2()
{
    if(!state2_)
    {
        this->clear();
        this->addWidget(initTex2());
        state2_ = true;
    }
    //hideAll();
    //tex2_->enable();
    //tex2_->show();
}
