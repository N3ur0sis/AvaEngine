#include "EditorLayer.h"
#include "imgui/imgui.h"
#include "glad/glad.h"

namespace Ava
{
	EditorLayer::EditorLayer() : Layer("EditorLayer")
	{
	}
	void EditorLayer::OnAttach()
	{
		FrameBufferSpecification fbSpec;
		fbSpec.width = 1280;
		fbSpec.height = 720;
		m_sceneBuffer = std::unique_ptr<FrameBuffer>(FrameBuffer::Create(fbSpec));
	}
	void EditorLayer::OnDetach()
	{
	}
	void EditorLayer::OnUpdate()
	{
		m_sceneBuffer->Bind();
		glClearColor(0.1f, 0.1f, 0.3f, 1.0f);
		glClear(GL_COLOR_BUFFER_BIT);
		m_sceneBuffer->Unbind();
		
	}
	void EditorLayer::OnImGuiRender()
	{
		if (ImGui::BeginMainMenuBar())
		{
			if (ImGui::BeginMenu("File"))
			{
				if (ImGui::MenuItem("Exit")) { Application::Get().Close(); }
				ImGui::EndMenu();
			}
			ImGui::EndMainMenuBar();
		}


		static ImGuiDockNodeFlags dockspace_flags = ImGuiDockNodeFlags_PassthruCentralNode;
		ImGui::DockSpaceOverViewport(ImGui::GetMainViewport(), dockspace_flags);


		ImGui::Begin("Settings");
		ImGui::Text("Renderer2D Stats:");
		ImGui::End();

		ImGui::PushStyleVar(ImGuiStyleVar_WindowPadding, ImVec2{ 0, 0 });
		ImGui::Begin("Viewport");
		ImVec2 viewportPanelSize = ImGui::GetContentRegionAvail();
		if (m_ViewportSize != *((glm::vec2*)&viewportPanelSize))
		{
			m_sceneBuffer->Resize((uint32_t)viewportPanelSize.x, (uint32_t)viewportPanelSize.y);
			m_ViewportSize = { viewportPanelSize.x, viewportPanelSize.y };
		
			
		}
		uint32_t textureID = m_sceneBuffer->GetFrameTexture();
		ImGui::Image((void*)textureID, ImVec2{ m_ViewportSize.x, m_ViewportSize.y }, ImVec2{ 0, 1 }, ImVec2{ 1, 0 });
		ImGui::End();
		ImGui::PopStyleVar();

	}
}

