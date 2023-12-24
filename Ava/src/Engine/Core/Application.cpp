#include "pch.h"
#include "Application.h"
#include "Engine/Core/Events/ApplicationEvent.h"
#include "Engine/Core/Log.h"
#include "glad/glad.h"
#include <GLFW/glfw3.h>


namespace Ava {

	Application* Application::s_Instance = nullptr;

	Ava::Application::Application(const std::string& name)
	{
		AVA_CORE_ASSERT(!s_Instance, "Application already exists!");
		s_Instance = this;
		m_Window = std::unique_ptr<Window>(Window::Create(WindowProps(name)));
		m_Window->SetEventCallback(std::bind(&Application::OnEvent, this, std::placeholders::_1));

		m_ImGuiLayer = new ImGuiLayer();
		PushOverlay(m_ImGuiLayer);
	}

	Ava::Application::~Application()
	{
	}

	void Ava::Application::Run()
	{
		
		while (m_running) 
		{
			m_Window->OnUpdate();
			for (Layer* layer : m_LayerStack)
				layer->OnUpdate();
			
			m_ImGuiLayer->Begin();
			for (Layer* layer : m_LayerStack)
				layer->OnImGuiRender();
			m_ImGuiLayer->End();
			
		}
	}

	void Application::OnEvent(Event& e)
	{
		EventDispatcher dispatcher(e);
		dispatcher.Dispatch<WindowCloseEvent>(std::bind(&Application::OnWindowClose, this, std::placeholders::_1));

		AVA_TRACE("{0}", e);

		for (auto i = m_LayerStack.end(); i != m_LayerStack.begin();)
		{
			(*--i)->OnEvent(e);
				if (e.Handled)
					break;
		}
	}

	void Application::PushLayer(Layer* layer)
	{
		m_LayerStack.PushLayer(layer);
	}

	void Application::PushOverlay(Layer* layer)
	{
		m_LayerStack.PushOverlay(layer);
	}

	bool Application::OnWindowClose(WindowCloseEvent& e)
	{
		m_running = false;
		return false;
	}


}

