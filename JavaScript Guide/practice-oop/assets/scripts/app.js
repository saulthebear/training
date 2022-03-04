class Tooltip {
  constructor(content) {
    this.content = content;
  }

  remove() {
    this.element.remove();
  }

  show() {
    this.element = document.createElement("div");
    this.element.className = "card";
    this.element.textContent = this.content;
    this.element.addEventListener("click", this.remove.bind(this));
    document.body.append(this.element);
  }
}

class Project {
  constructor(id, switchHandler) {
    this.id = id;
    this.switchHandler = switchHandler;
    this.element = document.getElementById(this.id);

    this.title = this.element.querySelector("h2").innerText;
    this.description = this.element.querySelector("p").innerText;

    this.connectSwitchButton();
    this.connectMoreInfoButton();
  }

  connectSwitchButton() {
    this.switchButton = this.element.querySelector("button:last-of-type");
    this.switchButton.addEventListener("click", this.switchHandler);
  }

  connectMoreInfoButton() {
    const button = this.element.querySelector("button");
    button.addEventListener("click", this.handleMoreInfo.bind(this));
  }

  handleMoreInfo() {
    const extraInfo = this.element.dataset.extraInfo;
    const tooltip = new Tooltip(extraInfo);
    tooltip.show();
  }

  update(newSwitchHandler, newType) {
    this.element = App.clearEventListners(this.element);
    this.switchHandler = newSwitchHandler;
    this.connectSwitchButton();

    const newButtonText = newType === App.ACTIVE ? "Finish" : "Activate";

    this.switchButton.textContent = newButtonText;
  }
}

class ProjectList {
  projects = [];
  constructor(projectsType) {
    this.projectsType = projectsType;

    this.sectionElement = document.getElementById(projectsType);
    const projectElements = this.sectionElement.querySelectorAll("li");

    for (let i = 0; i < projectElements.length; i += 1) {
      const id = projectElements[i].id;
      this.projects.push(new Project(id, this.switchProject.bind(this, id)));
    }
  }

  setSwitchHandlerFunction(switchHandlerFunction) {
    this.switchHandler = switchHandlerFunction;
  }

  switchProject(projectId) {
    this.switchHandler(this.projects.find((p) => p.id === projectId));
    this.projects = this.projects.filter((p) => p.id !== projectId);
  }

  addProject(project) {
    this.projects.push(project);
    const ul = this.sectionElement.querySelector("ul");
    App.moveDomElement(project.element, ul);

    project.update(
      this.switchProject.bind(this, project.id),
      this.projectsType
    );
  }
}

class App {
  static ACTIVE = "active-projects";
  static FINISHED = "finished-projects";
  static init() {
    this.activeProjects = new ProjectList(this.ACTIVE);
    this.finishedProjects = new ProjectList(this.FINISHED);

    this.activeProjects.setSwitchHandlerFunction(
      this.finishedProjects.addProject.bind(this.finishedProjects)
    );
    this.finishedProjects.setSwitchHandlerFunction(
      this.activeProjects.addProject.bind(this.activeProjects)
    );

    console.log(this.activeProjects);
    console.log(this.finishedProjects);
  }

  static moveDomElement(element, newParent) {
    newParent.append(element);
  }

  static clearEventListners(element) {
    const clonedElement = element.cloneNode(true);
    element.replaceWith(clonedElement);
    return clonedElement;
  }
}

App.init();
