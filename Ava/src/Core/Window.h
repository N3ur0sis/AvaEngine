#pragma once
#include "pch.h"
#include "Core/Core.h"
#include "Core/Events/Event.h"

namespace Ava
{
	struct WindowProps
	{
		std::string Title;
		unsigned int width;
		unsigned int height;
		//Basic Window Properties
		WindowProps(const std::string title = "Ava Engine",
					unsigned int width = 1280,
					unsigned int height = 720) : Title(title), width(width), height(height) {}
	};

	//Abstract Window Interface (to be implemented per platform)
	class AVA_API Window
	{
	public:
		using EventCallbackFn = std::function<void(Event&)>;

		virtual ~Window() {};
		virtual void OnUpdate() = 0;
		virtual unsigned int  GetWidth() const = 0;
		virtual unsigned int  GetHeight() const = 0;

		//Basic Window Class Attributes
		virtual void SetEventCallback(const EventCallbackFn& callback) = 0;
		virtual void SetVSync(bool enabled) = 0;
		virtual bool IsVSync() const = 0;

		static Window* Create(const WindowProps& props = WindowProps());

		virtual void* GetNativeWindow() const = 0;

	};
}
