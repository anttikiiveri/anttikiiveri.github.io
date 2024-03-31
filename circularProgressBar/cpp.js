document.addEventListener("DOMContentLoaded", function () {
    class CircularProgressBar {
        constructor(maxValue) {
            this.maxValue = maxValue;
            this.percent = 0;
            this.progressBar = document.querySelector(".progress");
            this.numbElement = document.querySelector(".numb");
            this._updateProgress();
        }

        _updateProgress() {
            this.percent = Math.min(100, Math.max(0, (this.value / this.maxValue) * 100));
            this.progressBar.style.transform = `rotate(${(this.percent / 100) * 360}deg)`;
            this.numbElement.textContent = `${Math.round(this.percent)}%`;
        }

        setValue(newValue) {
            this.value = Math.min(this.maxValue, Math.max(0, newValue));
            this._updateProgress();
        }
    }

    // Example usage:
    const progressBar = new CircularProgressBar(100);
    progressBar.setValue(75);
});
