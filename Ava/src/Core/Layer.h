#pragma once
#include <Core/Core.h>
#include <Core/Events/Event.h>


namespace Ava
{
	class AVA_API Layer
	{
	public:
		Layer(const std::string& name = "Layer");
		virtual ~Layer();
		virtual void OnAttach() {}
		virtual void OnDetach() {}
		virtual void OnImGuiRender() {}
		virtual void OnUpdate() {}
		virtual void OnEvent(Event& event) {}

		const std::string& Getname() const { return m_DebugName; }

	private: 
		std::string m_DebugName;
	};

}


