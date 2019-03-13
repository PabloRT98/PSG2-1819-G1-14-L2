<%@ page session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="petclinic" tagdir="/WEB-INF/tags" %>


<petclinic:layout pageName="bookings">
    <jsp:attribute name="customScript">
        <script>
            $(function () {
                $("#checkin").datepicker({dateFormat: 'yy/mm/dd'});
                $("#checkout").datepicker({dateFormat: 'yy/mm/dd'});
            });
        </script>
    </jsp:attribute>
    <jsp:body>
        <h2><c:if test="${booking['new']}"><fmt:message key="newBooking"/></c:if></h2>

        <b><fmt:message key="pet"/></b>
        <table class="table table-striped">
            <thead>
            <tr>
                <th><fmt:message key="name"/></th>
                <th><fmt:message key="birthDate"/></th>
                <th><fmt:message key="type"/></th>
                <th><fmt:message key="owner"/></th>
            </tr>
            </thead>
            <tr>
                <td><c:out value="${booking.pet.name}"/></td>
                <td><petclinic:localDate date="${booking.pet.birthDate}" pattern="yyyy/MM/dd"/></td>
                <td><c:out value="${booking.pet.type.name}"/></td>
                <td><c:out value="${booking.pet.owner.firstName} ${booking.pet.owner.lastName}"/></td>
            </tr>
        </table>

        <form:form modelAttribute="booking" class="form-horizontal">
            <div class="form-group has-feedback">
            	<fmt:message var="description" key="description"/>
            	<fmt:message var="checkin" key="checkin"/>
            	<fmt:message var="checkout" key="checkout"/>
                <petclinic:inputField label="${description}" name="description"/>
                <petclinic:inputField label="${checkin}" name="checkin"/>
                <petclinic:inputField label="${checkout}" name="checkout"/>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <input type="hidden" name="petName" value="${booking.petName}"/>
                    <button class="btn btn-default" type="submit"><fmt:message key="addBooking"/></button>
                </div>
            </div>
        </form:form>

        <br/>
        <b><fmt:message key="previousBooking"/></b>
        <table class="table table-striped">
            <tr>
            	<th><fmt:message key="description"/></th>
                <th><fmt:message key="checkin"/></th>
                <th><fmt:message key="checkout"/></th>
            </tr>
            <c:forEach var="booking" items="${booking.pet.bookings}">
                <c:if test="${!booking['new']}">
                    <tr>
                     	<td><c:out value="${booking.description}"/></td>
                        <td><petclinic:localDate date="${booking.checkin}" pattern="yyyy/MM/dd"/></td>
                        <td><petclinic:localDate date="${booking.checkout}" pattern="yyyy/MM/dd"/></td>
                    </tr>
                </c:if>
            </c:forEach>
        </table>
    </jsp:body>

</petclinic:layout>
