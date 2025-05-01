const backendURL = "https://my-resume-32bl.onrender.com";

document.getElementById("generate").addEventListener("click", async () => {
  const name = document.getElementById("recipient").value.trim();
  const email = document.getElementById("email").value.trim();
  const file = document.getElementById("resume").files[0];

  if (!name || !file) return alert("Enter a name and upload a resume");

  const formData = new FormData();
  formData.append("recipient", name);
  formData.append("email", email);
  formData.append("resume", file);

  try {
    const res = await fetch(`${backendURL}/upload`, {
      method: "POST",
      body: formData,
    });
    const data = await res.json();

    if (data.success) {
      const trackURL = `${backendURL}/track/${encodeURIComponent(name)}`;
      navigator.clipboard.writeText(trackURL);
      document.getElementById("output").textContent = `Link copied: ${trackURL}`;
    } else {
      alert("Upload failed");
    }
  } catch (err) {
    console.error(err);
    alert("Error uploading resume");
  }
});

// Update the openDashboard event listener to use your Render URL
document.getElementById("openDashboard").addEventListener("click", function() {
  // Replace with your actual Render deployment URL
  chrome.tabs.create({ url: "https://my-resume-32bl.onrender.com/dashboard.html" });
});