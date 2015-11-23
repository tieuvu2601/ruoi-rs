package com.banvien.portal.vms.jbpm.service;

import org.jbpm.api.Execution;
import org.jbpm.api.ProcessInstance;
import org.jbpm.api.task.Task;

import java.util.List;
import java.util.Map;

public interface JbpmSpringService {
	public void deploy(String processDefinitionFile);
	public boolean isProcessDeployed(String processDefinitionKey);
	public ProcessInstance startProcess(String processDefinitionKey, Map<String, Object> variables, String processInstanceKey);
	public ProcessInstance startProcess(String processDefinitionKey, String processInstanceKey);
	public ProcessInstance signal(Execution execution);
	public ProcessInstance executeTask(ProcessInstance instance, String taskName);
	public void assignToUser(String userName);
	public List<Task> getTaskListOfUser(String userName);
	public List<Long> getContentIDsInTaskOfUser(String userName);
	public void completeTask(String taskID, String transition);
	public void completeTask(String taskID, Map<String, Object> variables, String transition);
    public List<Long> getContentIDsUnAssignOfUser(String userName);
    public Object[] getContentIDsAndTaskMap(String userName);
    public void assignTask2User(Task task, String userName);
    public List<Task> getAllTask();
    public List<Task> getTaskListOfGroupOfUser(String userName);
    public List<String> getHistAssignee(String executionId);
}
