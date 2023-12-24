#pragma once

#include "Core.h"
#include "Window.h"
#include "LayerStack.h"
#include "Events/Event.h"
#include "Events/ApplicationEvent.h"
#include <Engine/Core/ImGui/ImGuiLayer.h>

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
		//Inline
		Window& GetWindow() { return *m_Window; }
		static Application& Get() { return *s_Instance; }
	private:
		std::unique_ptr<Window> m_Window;
		bool m_running = true;
		bool OnWindowClose(WindowCloseEvent& e);
		LayerStack m_LayerStack;
		static Application* s_Instance;
		ImGuiLayer* m_ImGuiLayer;
	};

	//Defined in clients
	Application* CreateApplication();
}

