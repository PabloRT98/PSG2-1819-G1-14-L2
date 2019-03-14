<%@ page session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="petclinic" tagdir="/WEB-INF/tags"%>

<petclinic:layout pageName="bookings">
	<h2>
		<fmt:message key ="bookingsof"/>
		<c:out
			value="${pet.name } (${pet.owner.firstName } ${pet.owner.lastName })" />
	</h2>
	<table id="bookingTable" class="table table-striped">
		<thead>
			<tr>
				<th><fmt:message key ="description"/></th>
				<th>Checkin</th>
				<th>Checkout</th>
				<th><fmt:message key ="actions"/></th>

			</tr>


		</thead>
		<tbody>
			<c:forEach items="${resultados}" var="booking">
				<tr>
					<td><c:out value="${booking.shortDescription}" /></td>

					<td><c:out value="${booking.checkin}" /></td>

					<td><c:out value="${booking.checkout}" /></td>

					<td>
					<spring:url value="/owners/{ownerId}/pets/{petId}/bookings/{bookId}/edit"
							var="editBookUrl">
							<spring:param name="ownerId" value="${booking.pet.owner.id}" />
							<spring:param name="petId" value="${booking.pet.id}" />
							<spring:param name="bookId" value="${booking.id}" />
						</spring:url> <a href="${fn:escapeXml(editBookUrl)}"><fmt:message key ="editBook"/></a>
						
						<spring:url value="/owners/{ownerId}/pets/{petId}/bookings/{bookingId}/delete"
							var="deleteBookUrl">
							<spring:param name="ownerId" value="${booking.pet.owner.id}" />
							<spring:param name="petId" value="${booking.pet.id}" />
							<spring:param name="bookingId" value="${booking.id}" />
						</spring:url> <a href="${fn:escapeXml(deleteBookUrl)}"><fmt:message key ="deleteBook"/></a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<spring:url value="/owners/{ownerId}/pets/{petId}/bookings/new"
							var="newBookUrl">
							<spring:param name="ownerId" value="${booking.pet.owner.id}" />
							<spring:param name="petId" value="${booking.pet.id}" />
						</spring:url> <a class="btn btn-default" href="${fn:escapeXml(newBookUrl)}"><fmt:message key ="newBook"/></a>
	
</petclinic:layout>
