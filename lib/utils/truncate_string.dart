String truncateString(String content, int maxLength) {
  if (content.length <= maxLength) {
    return content; // Return the original string if it's shorter than or equal to the desired length
  } else {
    return '${content.substring(0, maxLength)}...'; // Truncate and append "..."
  }
}
