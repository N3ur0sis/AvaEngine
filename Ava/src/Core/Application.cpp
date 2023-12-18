#include "pch.h"
#include "Application.h"
#include "Core/Events/ApplicationEvent.h"
#include "Core/Log.h"

namespace Ava {

	Ava::Application::Application()
	{
	}

	Ava::Application::~Application()
	{
	}

	void Ava::Application::Run()
	{
		WindowResizeEvent e(800, 600); 
		AVA_WARN(e);
		while (true);
	}


}

