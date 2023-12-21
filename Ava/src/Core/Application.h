#pragma once

#include "Core.h"
#include "Window.h"
#include "LayerStack.h"
#include "Events/Event.h"
#include "Events/ApplicationEvent.h"

namespace Ava {

	class AVA_API Application
	{
	public:
		Application(const std::string& name = "Ava Application");
		virtual ~Application();
		void Run();
		void OnEvent(Event& e);
		void PushLayer(Layer* layer);
		void PushOverlay(Layer* layer);
	private:
		std::unique_ptr<Window> m_Window;
		bool m_running = true;
		bool OnWindowClose(WindowCloseEvent& e);
		LayerStack m_LayerStack;
	};

	//Defined in clients
	Application* CreateApplication();
}

