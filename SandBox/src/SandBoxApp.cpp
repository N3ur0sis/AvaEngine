#include <Ava.h>
#include <Engine/Core/EntryPoint.h>

class SandBox : public Ava::Application
{
public:
	SandBox()
	{

	}
	~SandBox()
	{

	}

};

Ava::Application* Ava::CreateApplication()
{
	return new SandBox();
}