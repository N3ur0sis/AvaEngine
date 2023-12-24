#include <Ava.h>
#include <Engine/Core/EntryPoint.h>
#include "EditorLayer.h"

namespace Ava {

	class AvaEditor : public Application
	{
	public:
		AvaEditor() : Application("Ava Editor")
		{
			PushLayer(new EditorLayer());
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
