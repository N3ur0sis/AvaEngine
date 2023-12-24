#include "EditorLayer.h"
#include "imgui/imgui.h"

namespace Ava
{
	EditorLayer::EditorLayer() : Layer("EditorLayer")
	{
	}
	void EditorLayer::OnAttach()
	{
	}
	void EditorLayer::OnDetach()
	{
	}
	void EditorLayer::OnImGuiRender()
	{
		ImGui::Begin("Editor Layer");
		ImGui::Text("Test Text");
		ImGui::End();
	}
}

