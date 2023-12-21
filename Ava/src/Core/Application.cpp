#include "pch.h"
#include "Application.h"
#include "Core/Events/ApplicationEvent.h"
#include "Core/Log.h"
#include "glad/glad.h"
#include <GLFW/glfw3.h>


namespace Ava {

	Ava::Application::Application(const std::string& name)
	{
		m_Window = std::unique_ptr<Window>(Window::Create(WindowProps(name)));
		m_Window->SetEventCallback(std::bind(&Application::OnEvent, this, std::placeholders::_1));
	}

	Ava::Application::~Application()
	{
	}

	void Ava::Application::Run()
	{
		
		while (m_running) 
		{
			glClearColor(0.1f, 0.1f, 0.1f, 1.0f);
			glClear(GL_COLOR_BUFFER_BIT);
			m_Window->OnUpdate();

			for (Layer* layer : m_LayerStack)
				layer->OnUpdate();
			
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

