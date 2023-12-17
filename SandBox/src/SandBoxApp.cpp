#include <Ava.h>

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