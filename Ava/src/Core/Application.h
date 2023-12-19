#pragma once
#include "Core.h"
#include "Events/Event.h"
#include "Window.h"
#include "Core/Events/ApplicationEvent.h"

namespace Ava {

	class AVA_API Application
	{
	public:
		Application();
		virtual ~Application();
		void Run();
		void OnEvent(Event& e);
	private:
		std::unique_ptr<Window> m_Window;
		bool m_running = true;
		bool OnWindowClose(WindowCloseEvent& e);
	};

	//Defined in clients
	Application* CreateApplication();
}

