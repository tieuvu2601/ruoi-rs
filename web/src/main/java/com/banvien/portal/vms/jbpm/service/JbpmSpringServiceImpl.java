package com.banvien.portal.vms.jbpm.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jbpm.api.Execution;
import org.jbpm.api.ExecutionService;
import org.jbpm.api.HistoryService;
import org.jbpm.api.NewDeployment;
import org.jbpm.api.ProcessInstance;
import org.jbpm.api.RepositoryService;
import org.jbpm.api.TaskQuery;
import org.jbpm.api.TaskService;
import org.jbpm.api.history.HistoryTask;
import org.jbpm.api.task.Task;

public class JbpmSpringServiceImpl implements JbpmSpringService{
	private transient final Log log = LogFactory.getLog(getClass());

    @Override
    public void assignTask2User(Task task, String userName) {
        taskService.takeTask(task.getId(), userName);
    }

    private RepositoryService repositoryService;
	private ExecutionService  executionService;
	private TaskService taskService;
	private HistoryService historyService;
	
	@Override
	public void deploy(String processDefinitionFile) {
		NewDeployment deployment = repositoryService.createDeployment();
		deployment.addResourceFromClasspath(processDefinitionFile);
		deployment.deploy();
	}

	@Override
	public boolean isProcessDeployed(String processDefinitionKey) {
		return repositoryService.createProcessDefinitionQuery().processDefinitionKey(processDefinitionKey).list().size() > 0;
	}

	@Override
	public ProcessInstance  startProcess(String processDefinitionKey, Map<String, Object> variables, String processInstanceKey){
		return executionService.startProcessInstanceByKey(processDefinitionKey, variables, processInstanceKey);
	}
	@Override
	public ProcessInstance startProcess(String processDefinitionKey,
			String processInstanceKey) {
		return executionService.startProcessInstanceByKey(processDefinitionKey, processInstanceKey);
	}
	@Override
	public ProcessInstance signal(Execution execution) {
		if (execution.getState().equals(Execution.STATE_INACTIVE_SCOPE)) {
			  execution =  execution.getExecutions().iterator().next();
		}
		  
		return executionService.signalExecutionById(execution.getId(), "transition");
	}
	@Override
	public ProcessInstance executeTask(ProcessInstance instance, String taskName) {
		Execution execution = instance.findActiveExecutionIn(taskName);
		return executionService.signalExecutionById(execution.getId(), "transition");
	}
	

	public void setRepositoryService(RepositoryService repositoryService) {
		this.repositoryService = repositoryService;
	}

	public void setExecutionService(ExecutionService executionService) {
		this.executionService = executionService;
	}
	
	public void setTaskService(TaskService taskService) {
		this.taskService = taskService;
	}

	@Override
	public void assignToUser(String userName) {
		List<Task> taskList = taskService.findGroupTasks(userName);
		for(Task task : taskList) {
			taskService.takeTask(task.getId(), userName);
		}
	}

	@Override
	public List<Task> getTaskListOfUser(String userName) {
		return taskService.findPersonalTasks(userName);
	}
	
	@Override
	public List<Task> getTaskListOfGroupOfUser(String userName) {
		return taskService.findGroupTasks(userName);
	}

	@Override
	public List<Long> getContentIDsInTaskOfUser(String userName) {
		List<Long> contentIDs = new ArrayList<Long>();
		List<Task> taskList = taskService.findPersonalTasks(userName);
		for(Task task : taskList) {
			try {
				String processID = task.getExecutionId();
				Long contentID = Long.valueOf(processID.split("\\.")[1]);
				contentIDs.add(contentID);
			}catch (Exception e) {
				log.error(e.getMessage(), e);
			}
		}
		return contentIDs;
	}

	@Override
	public void completeTask(String taskID, String transition) {
		taskService.completeTask(taskID, transition);
	}

    @Override
    public List<Long> getContentIDsUnAssignOfUser(String userName) {
        List<Task> taskList = taskService.findGroupTasks(userName);
        List<Long> contentIDs = new ArrayList<Long>();
        for(Task task : taskList) {
            try {
                String processID = task.getExecutionId();
                Long contentID = Long.valueOf(processID.split("\\.")[1]);
                contentIDs.add(contentID);
            }catch (Exception e) {
                log.error(e.getMessage(), e);
            }
        }
        return contentIDs;
    }

    @Override
    public Object[] getContentIDsAndTaskMap(String userName){
    	
    	Map<Long, Task> taskMap = new HashMap<Long, Task>();
    	Map<Long, Boolean> processIDs = new HashMap<Long, Boolean>();
    	List<Task> tasks = taskService.createTaskQuery().assignee(userName).candidate(userName).orderDesc(TaskQuery.PROPERTY_PRIORITY).list();
    	for(Task task : tasks){
            String processID = task.getExecutionId();
            Long contentID = Long.valueOf(processID.split("\\.")[1]);
            processIDs.put(contentID, true);
            taskMap.put(contentID, task);
        }
    	return new Object[]{processIDs, taskMap};
    }

	@Override
	public List<Task> getAllTask() {
		return taskService.createTaskQuery().list();
	}

	@Override
	public void completeTask(String taskID, Map<String, Object> variables,
			String transition) {
		taskService.setVariables(taskID, variables);
		taskService.completeTask(taskID, transition);
	}
	
	public List<String> getHistAssignee(String executionId){
		List<String> assigneeList = new ArrayList<String>();
		List<HistoryTask> hTasks = historyService.createHistoryTaskQuery().executionId(executionId).list();
		for(HistoryTask hTask : hTasks){
			if(StringUtils.isNotEmpty(hTask.getAssignee())){
				assigneeList.add(hTask.getAssignee());
			}
		}
		return assigneeList;
	}

	public void setHistoryService(HistoryService historyService) {
		this.historyService = historyService;
	}

}
