unit ContainerDI;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, TasksUseCase, TasksRepository, TasksRepositoryImpl,
  TasksDataSourceSQL, TasksListView, TasksDetailsView;

type
  TContainerDI = class
    public
      class procedure Initialize;
  end;

implementation

class procedure TContainerDI.Initialize;
var
  TasksRepository: ITasksRepository;
  TasksDataSource: TTasksDataSourceSQL;
  TasksUseCase: TTasksUseCase;
begin
  TasksDataSource := TTasksDataSourceSQL.Create;
  TasksRepository := TTasksRepositoryImpl.Create(TasksDataSource);
  TasksUseCase := TTasksUseCase.Create(TasksRepository);

  frTasksList.InitializeTasksUseCase(TasksUseCase);
  frTasksDetails.InitializeTasksUseCase(TasksUseCase);
end;

end.

