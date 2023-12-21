#include <Ava.h>
#include <Core/EntryPoint.h>

namespace Ava {

	class AvaEditor : public Ava::Application
	{
	public:
		AvaEditor() : Application("Ava Editor")
		{
	
		}
		~AvaEditor()
		{
	
		}
	
	};
	
	Application* CreateApplication()
	{
		return new AvaEditor();
	}
}
