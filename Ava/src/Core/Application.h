#pragma once
#include "Core.h"
#include "Events/Event.h"

namespace Ava {

	class AVA_API Application
	{
	public:
		Application();
		virtual ~Application();
		void Run();
	};

	//Defined in clients
	Application* CreateApplication();
}

