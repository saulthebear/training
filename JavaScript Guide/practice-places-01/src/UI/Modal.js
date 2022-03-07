export default class Modal {
  constructor(contentTemplateId, fallbackText) {
    this.fallbackText = fallbackText;
    this.contentTemplateElement = document.getElementById(contentTemplateId);
    this.modalTemplateElement = document.getElementById("modal-template");
  }
  show() {
    // Check if template tag is supported
    if ("content" in document.createElement("template")) {
      const modalElements = document.importNode(
        this.modalTemplateElement.content,
        true
      );
      this.modalElement = modalElements.querySelector(".modal");
      this.backdropElement = modalElements.querySelector(".backdrop");
      const contentElement = document.importNode(
        this.contentTemplateElement.content,
        true
      );

      this.modalElement.append(contentElement);

      document.body.insertAdjacentElement("afterbegin", this.modalElement);
      document.body.insertAdjacentElement("afterbegin", this.backdropElement);
    } else {
      alert(this.fallbackText);
    }
  }

  hide() {
    this.modalElement.remove();
    this.backdropElement.remove();
    this.modalElement = null;
    this.backdropElement = null;
  }
}
