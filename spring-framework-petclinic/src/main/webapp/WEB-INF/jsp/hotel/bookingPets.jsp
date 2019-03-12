<%@ page session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="petclinic" tagdir="/WEB-INF/tags" %>


<petclinic:layout pageName="hotel">

    <jsp:attribute name="customScript">
        <script>
            $(function () {
                $("#date").datepicker({dateFormat: 'yy/mm/dd'});
            });
        </script>
    </jsp:attribute>
    <jsp:body>
        <h2><c:if test="${visit['new']}"> <fmt:message key="New"/> </c:if> <fmt:message key="booking"/></h2>

        <b> <fmt:message key="description"/></b>
        <table class="table table-striped">
            <thead>
            <tr>
                <th> <fmt:message key="name"/></th>
                <th> <fmt:message key="birthDate"/></th>
                <th> <fmt:message key="type"/></th>
                <th> <fmt:message key="checkin"/></th>
               <th><fmt:message key="checkout"/></th>   
               <th><fmt:message key="shortDescription"/></th>             
            </tr>
            </thead>
            <tr>
                <td><c:out value="${visit.pet.name}"/></td>
                <td><petclinic:localDate date="${visit.pet.birthDate}" pattern="yyyy/MM/dd"/></td>
                <td><c:out value="${visit.pet.type.name}"/></td>
                <td><petclinic:localDate date="${visit.pet.checkin}" pattern="yyyy/MM/dd"/></td>
                <td><petclinic:localDate date="${visit.pet.checkout}" pattern="yyyy/MM/dd"/></td>
                <td><c:out value="${visit.pet.shortDescription}"/></td>

            </tr>
        </table>

        <form:form modelAttribute="visit" class="form-horizontal">
            <div class="form-group has-feedback">
                <petclinic:inputField label="Date" name="date"/>
                <petclinic:inputField label="Description" name="description"/>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <input type="hidden" name="petId" value="${visit.pet.id}"/>
                    <button class="btn btn-default" type="submit"><fmt:message key="addBooking"/></button>
                </div>
            </div>
        </form:form>

        <br/>
        <b> <fmt:message key="previousBooking"/></b>
        <table class="table table-striped">
            <tr>
                <th> <fmt:message key="checkin"/></th>
                <th> <fmt:message key="checkout"/></th>
            </tr>
            <c:forEach var="visit" items="${visit.pet.visits}">
                <c:if test="${!visit['new']}">
                    <tr>
                        <td><petclinic:localDate date="${visit.chekin}" pattern="yyyy/MM/dd"/></td>
                        <td><petclinic:LocalDate date="${visit.checkout}"pattern="yyyy/MM/dd"/></td>
                    </tr>
                </c:if>
            </c:forEach>
        </table>
    </jsp:body>

</petclinic:layout>
