#pragma once

#ifdef AVA_PLATFORM_WINDOWS

extern Ava::Application* Ava::CreateApplication();

int main(int argc, char** argv)
{
	Ava::Log::Init();
	AVA_CORE_INFO("Initialized Log!");
	auto app = Ava::CreateApplication();
	app->Run();
	delete app;
}

#endif // AVA_PLATFORM_WINDOWS
