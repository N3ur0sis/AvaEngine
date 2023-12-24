#pragma once
#include <Ava.h>
#include <glm/glm.hpp>
namespace Ava
{
	class EditorLayer : public Layer
	{
	public:
		EditorLayer();
		virtual ~EditorLayer() = default;
		virtual void OnAttach() override;
		virtual void OnDetach() override;
		virtual void OnUpdate() override;
		virtual void OnImGuiRender() override;
	private:
		std::shared_ptr<FrameBuffer> m_sceneBuffer;
		glm::vec2 m_ViewportSize = { 0.0f, 0.0f };
	};


}
