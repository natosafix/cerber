export function onDomContentLoaded(callback: () => void) {
  if (
    document.readyState === "complete" ||
    document.readyState === "interactive"
  ) {
    callback();
  } else {
    window.addEventListener("DOMContentLoaded", callback);
  }
}
