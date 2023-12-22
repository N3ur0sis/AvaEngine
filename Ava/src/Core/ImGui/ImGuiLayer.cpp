#include "pch.h"
#include "imgui.h"
#include "ImGuiLayer.h"
#include <Core/Application.h>
#include <GLFW/glfw3.h>
#include <glad/glad.h>
#include <backends/imgui_impl_glfw.h>
#include <backends/imgui_impl_opengl3.h>



Ava::ImGuiLayer::ImGuiLayer()
{
	OnAttach();
}

Ava::ImGuiLayer::~ImGuiLayer()
{
}

void Ava::ImGuiLayer::OnAttach()
{
	//Setting up Imgui
	IMGUI_CHECKVERSION();
	ImGui::CreateContext();
	ImGuiIO& io = ImGui::GetIO(); (void)io;
	io.ConfigFlags |= ImGuiConfigFlags_NavEnableKeyboard;
	io.ConfigFlags |= ImGuiConfigFlags_DockingEnable;
	io.ConfigFlags |= ImGuiConfigFlags_ViewportsEnable;
	//Styling ImGui
	ImGui::StyleColorsDark();
	ImGuiStyle& style = ImGui::GetStyle();
	if (io.ConfigFlags & ImGuiConfigFlags_ViewportsEnable) {
		style.WindowRounding = 0.0f;
		style.Colors[ImGuiCol_WindowBg].w = 1.0f;
	}
	//Get the window reference
	Application& app = Application::Get();
	GLFWwindow* window = static_cast<GLFWwindow*>(app.GetWindow().GetNativeWindow());
	// initialize ImGui's glfw/opengl implementation 
	ImGui_ImplGlfw_InitForOpenGL(window, true);
	ImGui_ImplOpenGL3_Init("#version 460");
}

void Ava::ImGuiLayer::OnDetach()
{
	ImGui_ImplOpenGL3_Shutdown();
	ImGui_ImplGlfw_Shutdown();
	ImGui::DestroyContext();
}

void Ava::ImGuiLayer::OnImGuiRender()
{
	static bool show = true;
	ImGui::ShowDemoWindow(&show);
}

void Ava::ImGuiLayer::Begin()
{
	ImGui_ImplOpenGL3_NewFrame();
	ImGui_ImplGlfw_NewFrame();
	ImGui::NewFrame();
}

void Ava::ImGuiLayer::End()
{
	ImGuiIO& io = ImGui::GetIO();
	Application& app = Application::Get();
	io.DisplaySize = ImVec2(app.GetWindow().GetWidth(), app.GetWindow().GetHeight());

	// Rendering
	ImGui::Render();
	glClearColor(0.1f, 0.1f, 0.1f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT);
	ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());

	if (io.ConfigFlags & ImGuiConfigFlags_ViewportsEnable)
	{
		GLFWwindow* backup_current_context = glfwGetCurrentContext();
		ImGui::UpdatePlatformWindows();
		ImGui::RenderPlatformWindowsDefault();
		glfwMakeContextCurrent(backup_current_context);
	}
}
