<%@ page import="java.util.*" %>
<%@ page import="tachyon.web.*" %>

<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
</head>
<title>Tachyon</title>
<body>
<script src="js/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js"></script>
<div class="container-fluid">
  <div class="navbar navbar-inverse">
    <div class="navbar-inner">
      <ul class="nav nav-pills">
        <li><a href="./home">Master: <%= request.getAttribute("masterNodeAddress") %></a></li>
        <li class="active"><a href="./browse?path=/">Browse File System</a></li>
        <li><a href="./memory">View Files in Memory</a></li>
      </ul>
    </div>
  </div>

  <div class="container-fluid">
    <div class="row-fluid">
      <div class="span12 well">
        <h1 class="text-error">
          <%= request.getAttribute("invalidPathError") %>
        </h1>
        <div class="navbar">
          <div class="navbar-inner">
            <ul class="nav nav-pills">
              <% if (request.getAttribute("pathInfos") != null) { %>
                <% for (WebInterfaceBrowseServlet.UiFileInfo pathInfo : ((WebInterfaceBrowseServlet.UiFileInfo[]) request.getAttribute("pathInfos"))) { %>
                  <li><a href="./browse?path=<%= pathInfo.getAbsolutePath() %>"><%= pathInfo.getName() %> </a></li>
                <% } %>
              <% } %>
              <% if (request.getAttribute("currentDirectory") != null) { %>
                <li class="active"><a href="./browse?path=<%= request.getAttribute("currentPath") %>"><%= ((WebInterfaceBrowseServlet.UiFileInfo) request.getAttribute("currentDirectory")).getName() %></a></li>
              <% } %>
            </ul>
          </div>
        </div>
        <table class="table table-condensed">
          <thead>
            <th>File Name</th>
            <th>Size</th>
            <th>Block Size</th>
            <th>In-Memory</th>
            <th>Creation Time</th>
          <!--
            <c:if test = "${debug}">
              <th>[D]Inode Number</th>
              <th>[D]Checkpoint Path</th>
            </c:if>
          -->
            <% if ((Boolean) request.getAttribute("debug")) { %>
              <th>[D]Dependency Id</th>
              <th>[D]Inode Number</th>
              <th>[D]Checkpoint Path</th>
              <th>[D]File Locations</th>
            <% } %>
          </thead>
          <tbody>
            <!--
            <c:forEach var="fileInfo" items="${fileInfos}">
              <tr>
                <th>
                  <c:if test = "${fileInfo.isDirectory}">
                    <i class="icon-folder-close"></i>
                  </c:if>
                  <c:if test = "${not fileInfo.isDirectory}">
                    <i class="icon-file"></i>
                  </c:if>
                  <a href="./browse?path=${fileInfo.absolutePath}"><c:out value="${fileInfo.name}"/></a>
                </th>
                <th>${fileInfo.size} Bytes</th>
                <th>${fileInfo.blockSizeBytes}</th>
                <th>
                  <c:if test = "${fileInfo.inMemory}">
                    <i class="icon-hdd"></i>
                  </c:if>
                  <c:if test = "${not fileInfo.inMemory}">
                    <i class="icon-hdd icon-white"></i>
                  </c:if>
                </th>
                <th>${fileInfo.creationTime}</th>
                <th>
                  <c:if test = "${fileInfo.dependencyId} != -1">
                    <a href="./dependency?id=${fileInfo.dependencyId}&filePath=${fileInfo.absolutePath}"><c:out value="${fileInfo.dependencyId}"/></a>
                  </c:if>
                </th>
                <c:if test = "${debug}">
                  <th>${fileInfo.id}</th>
                  <th>${fileInfo.checkpointPath}</th>
                  <th>
                  <c:forEach var="location" items="${fileInfo.fileLocations}">
                    ${location}<br/>
                  </c:forEach>
                  </th>
                </c:if>
              </tr>
            </c:forEach>
          -->
            <% if (request.getAttribute("fileInfos") != null) { %>
              <% for (WebInterfaceBrowseServlet.UiFileInfo fileInfo : ((List<WebInterfaceBrowseServlet.UiFileInfo>) request.getAttribute("fileInfos"))) { %>
                <tr>
                  <th>
                    <% if (fileInfo.getIsDirectory()) { %>
                      <i class="icon-folder-close"></i>
                    <% } %>
                    <% if (!fileInfo.getIsDirectory()) { %>
                      <i class="icon-file"></i>
                    <% } %>
                    <a href="./browse?path=<%=fileInfo.getAbsolutePath()%>"><%= fileInfo.getName() %></a>
                  </th>
                  <th><%= fileInfo.getSize() %></th>
                  <th><%= fileInfo.getBlockSizeBytes() %></th>
                  <th>
                    <% if (fileInfo.getInMemory()) { %>
                      <i class="icon-hdd"></i>
                    <% } %>
                    <% if (!fileInfo.getInMemory()) { %>
                      <i class="icon-hdd icon-white"></i>
                    <% } %>
                    <%= fileInfo.getInMemoryPercentage() %>%
                  </th>
                  <th><%= fileInfo.getCreationTime() %></th>
                  <% if ((Boolean) request.getAttribute("debug")) { %>
                    <th>
                      <% if (fileInfo.getDependencyId() != -1) { %>
                        <a href="./dependency?id=<%=fileInfo.getDependencyId()%>&filePath=<%=fileInfo.getAbsolutePath()%>"><%= fileInfo.getDependencyId() %></a>
                      <% } %>
                    </th>
                    <th><%= fileInfo.getId() %></th>
                    <th><%= fileInfo.getCheckpointPath() %></th>
                    <th><% for (String location : fileInfo.getFileLocations()) { %>
                          <%= location %> <br/>
                        <% } %>
                    </th>
                  <% } %>
                </tr>
              <% } %>
            <% } %>
          </tbody>
        </table>
      </div>
    </div>
  </div>
  <footer>
    <p style="text-align: center;">
      Tachyon is a project developed at the UC Berkeley <a href="https://amplab.cs.berkeley.edu">AMPLab</a>.
    </p>
  </footer>
</div>
</body>
</html>