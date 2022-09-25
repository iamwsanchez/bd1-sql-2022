using System;
using System.Collections.Generic;
using System.ComponentModel;

namespace JadeWebApp.Models
{
    public partial class Employee
    {
        /// <summary>
        /// Identificador único del empleado (Autonumérico)
        /// </summary>
        [DisplayName("Id")]
        public short Id { get; set; }
        /// <summary>
        /// Primer nombre del empleado
        /// </summary>
        [DisplayName("Primer nombre")]
        public string FirstName { get; set; } = null!;
        /// <summary>
        /// Segundo nombre del empleado
        /// </summary>
        [DisplayName("Segundo nombre")]
        public string? MiddleName { get; set; }
        /// <summary>
        /// Apellido del empleado
        /// </summary>
        [DisplayName("Apellidos")]
        public string LastName { get; set; } = null!;
        /// <summary>
        /// Identificador del puesto de trabajo que ocupa el empleado
        /// </summary>
        [DisplayName("Puesto")]
        public byte JobId { get; set; }
        [DisplayName("Puesto")]
        public virtual Job Job { get; set; } = null!;
    }
}
