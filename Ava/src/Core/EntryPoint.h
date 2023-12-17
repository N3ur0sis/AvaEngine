#pragma once

#ifdef AVA_PLATFORM_WINDOWS

extern Ava::Application* Ava::CreateApplication();

int main(int argc, char** argv)
{

	auto app = Ava::CreateApplication();
	app->Run();
	delete app;
}

#endif // AVA_PLATFORM_WINDOWS
