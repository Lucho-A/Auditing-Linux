-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: 192.168.1.6    Database: Auditing-Linux
-- ------------------------------------------------------
-- Server version	8.0.27-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Findings`
--

DROP TABLE IF EXISTS `Findings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Findings` (
  `idFinding` varchar(45) NOT NULL,
  `idSeverity` int DEFAULT NULL,
  `Title` longtext,
  `Description` longtext,
  `Detail` longtext,
  `How_to_Fix` longtext,
  PRIMARY KEY (`idFinding`),
  KEY `fkIdSeverity_idx` (`idSeverity`),
  CONSTRAINT `fkIdSeverity` FOREIGN KEY (`idSeverity`) REFERENCES `Severities` (`idSeverity`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Findings`
--

LOCK TABLES `Findings` WRITE;
/*!40000 ALTER TABLE `Findings` DISABLE KEYS */;
INSERT INTO `Findings` VALUES ('V-204452',3,'The Red Hat Enterprise Linux operating system must remove all software components after updated versions have been installed.','Previous versions of software components that are not removed from the information system after updates have been installed may be exploited by adversaries. Some information technology products...','Verify the operating system removes all software components after updated versions have been installed.\n\nCheck if yum is configured to remove unneeded packages with the following command:\n\n# grep -i clean_requirements_on_remove /etc/yum.conf\nclean_requirements_on_remove=1\n\nIf \"clean_requirements_on_remove\" is not set to \"1\", \"True\", or \"yes\", or is not set in \"/etc/yum.conf\", this is a finding.','Configure the operating system to remove all software components after updated versions have been installed.\n\nSet the \"clean_requirements_on_remove\" option to \"1\" in the \"/etc/yum.conf\" file:\n\nclean_requirements_on_remove=1'),('V-204461',3,'The Red Hat Enterprise Linux operating system must be configured so that all Group Identifiers (GIDs) referenced in the /etc/passwd file are defined in the /etc/group file.','If a user is assigned the GID of a group not existing on the system, and a group with the GID is subsequently created, the user may have unintended rights to any files associated with the group.','Verify all GIDs referenced in the \"/etc/passwd\" file are defined in the \"/etc/group\" file.\n\nCheck that all referenced GIDs exist with the following command:\n\n# pwck -r\n\nIf GIDs referenced in \"/etc/passwd\" file are returned as not defined in \"/etc/group\" file, this is a finding.','Configure the system to define all GIDs found in the \"/etc/passwd\" file by modifying the \"/etc/group\" file to add any non-existent group referenced in the \"/etc/passwd\" file, or change the GIDs referenced in the \"/etc/passwd\" file to a group that exists in \"/etc/group\".'),('V-204486',3,'The Red Hat Enterprise Linux operating system must mount /dev/shm with secure options.','The \"noexec\" mount option causes the system to not execute binary files. This option must be used for mounting any file system not containing approved binary files as they may be incompatible....','Verify that the \"nodev\",\"nosuid\", and \"noexec\" options are configured for /dev/shm:\n\n# cat /etc/fstab | grep /dev/shm\n\ntmpfs /dev/shm tmpfs defaults,nodev,nosuid,noexec 0 0\n\nIf results are returned and the \"nodev\", \"nosuid\", or \"noexec\" options are missing, this is a finding.\n\nVerify \"/dev/shm\" is mounted with the \"nodev\", \"nosuid\", and \"noexec\" options:\n\n# mount | grep /dev/shm\n\ntmpfs on /dev/shm type tmpfs (rw,nodev,nosuid,noexec,seclabel)\n\nIf /dev/shm is mounted without secure options \"nodev\", \"nosuid\", and \"noexec\", this is a finding.','Configure the system so that /dev/shm is mounted with the \"nodev\", \"nosuid\", and \"noexec\" options by adding /modifying the /etc/fstab with the following line:\n\ntmpfs /dev/shm tmpfs defaults,nodev,nosuid,noexec 0 0'),('V-204493',3,'The Red Hat Enterprise Linux operating system must be configured so that a separate file system is used for user home directories (such as /home or an equivalent).','The use of separate file systems for different paths can protect the system from failures resulting from a file system becoming full or failing.','Verify that a separate file system/partition has been created for non-privileged local interactive user home directories.\n\nCheck the home directory assignment for all non-privileged users (those with a UID of 1000 or greater) on the system with the following command:\n\n# awk -F: \'($3>=1000)&&($7 !~ /nologin/){print $1, $3, $6, $7}\' /etc/passwd\n\nadamsj 1000 /home/adamsj /bin/bash\njacksonm 1001 /home/jacksonm /bin/bash\nsmithj 1002 /home/smithj /bin/bash\n\nThe output of the command will give the directory/partition that contains the home directories for the non-privileged users on the system (in this example, /home) and users\' shell. All accounts with a valid shell (such as /bin/bash) are considered interactive users.\n\nCheck that a file system/partition has been created for the non-privileged interactive users with the following command:\n\nNote: The partition of /home is used in the example.\n\n# grep /home /etc/fstab\nUUID=333ada18 /home ext4 noatime,nobarrier,nodev 1 2\n\nIf a separate entry for the file system/partition that contains the non-privileged interactive users\' home directories does not exist, this is a finding.','Migrate the \"/home\" directory onto a separate file system/partition.'),('V-204494',3,'The Red Hat Enterprise Linux operating system must use a separate file system for /var.','The use of separate file systems for different paths can protect the system from failures resulting from a file system becoming full or failing.','Verify that a separate file system/partition has been created for \"/var\".\n\nCheck that a file system/partition has been created for \"/var\" with the following command:\n\n# grep /var /etc/fstab\nUUID=c274f65f /var ext4 noatime,nobarrier 1 2\n\nIf a separate entry for \"/var\" is not in use, this is a finding.','Migrate the \"/var\" path onto a separate file system.'),('V-204495',3,'The Red Hat Enterprise Linux operating system must use a separate file system for the system audit data path.','The use of separate file systems for different paths can protect the system from failures resulting from a file system becoming full or failing.','Determine if the operating system is configured to have the \"/var/log/audit\" path is on a separate file system.\n\n# grep /var/log/audit /etc/fstab\n\nIf no result is returned, or the operating system is not configured to have \"/var/log/audit\" on a separate file system, this is a finding.\n\nVerify that \"/var/log/audit\" is mounted on a separate file system:\n\n# mount | grep \"/var/log/audit\"\n\nIf no result is returned, or \"/var/log/audit\" is not on a separate file system, this is a finding.','Migrate the system audit data path onto a separate file system.'),('V-204496',3,'The Red Hat Enterprise Linux operating system must use a separate file system for /tmp (or equivalent).','The use of separate file systems for different paths can protect the system from failures resulting from a file system becoming full or failing.','Verify that a separate file system/partition has been created for \"/tmp\".\n\nCheck that a file system/partition has been created for \"/tmp\" with the following command:\n\n# systemctl is-enabled tmp.mount\nenabled\n\nIf the \"tmp.mount\" service is not enabled, check to see if \"/tmp\" is defined in the fstab with a device and mount point:\n\n# grep -i /tmp /etc/fstab\nUUID=a411dc99-f2a1-4c87-9e05-184977be8539 /tmp ext4 rw,relatime,discard,data=ordered,nosuid,noexec, 0 0\n\nIf \"tmp.mount\" service is not enabled or the \"/tmp\" directory is not defined in the fstab with a device and mount point, this is a finding.','Start the \"tmp.mount\" service with the following command:\n\n# systemctl enable tmp.mount\n\nOR\n\nEdit the \"/etc/fstab\" file and ensure the \"/tmp\" directory is defined in the fstab with a device and mount point.'),('V-204498',3,'The Red Hat Enterprise Linux operating system must be configured so that the file integrity tool is configured to verify Access Control Lists (ACLs).','ACLs can provide permissions beyond those permitted through the file mode and must be verified by file integrity tools.','Verify the file integrity tool is configured to verify ACLs.\n\nCheck to see if Advanced Intrusion Detection Environment (AIDE) is installed on the system with the following command:\n\n# yum list installed aide\n\nIf AIDE is not installed, ask the System Administrator how file integrity checks are performed on the system.\n\nIf there is no application installed to perform file integrity checks, this is a finding.\n\nNote: AIDE is highly configurable at install time. These commands assume the \"aide.conf\" file is under the \"/etc\" directory.\n\nUse the following command to determine if the file is in another location:\n\n# find / -name aide.conf\n\nCheck the \"aide.conf\" file to determine if the \"acl\" rule has been added to the rule list being applied to the files and directories selection lists.\n\nAn example rule that includes the \"acl\" rule is below:\n\nAll= p+i+n+u+g+s+m+S+sha512+acl+xattrs+selinux\n/bin All # apply the custom rule to the files in bin\n/sbin All # apply the same custom rule to the files in sbin\n\nIf the \"acl\" rule is not being used on all uncommented selection lines in the \"/etc/aide.conf\" file, or ACLs are not being checked by another file integrity tool, this is a finding.','Configure the file integrity tool to check file and directory ACLs.\n\nIf AIDE is installed, ensure the \"acl\" rule is present on all uncommented file and directory selection lists.'),('V-204499',3,'The Red Hat Enterprise Linux operating system must be configured so that the file integrity tool is configured to verify extended attributes.','Extended attributes in file systems are used to contain arbitrary data and file metadata with security implications.','Verify the file integrity tool is configured to verify extended attributes.\n\nCheck to see if Advanced Intrusion Detection Environment (AIDE) is installed on the system with the following command:\n\n# yum list installed aide\n\nIf AIDE is not installed, ask the System Administrator how file integrity checks are performed on the system.\n\nIf there is no application installed to perform file integrity checks, this is a finding.\n\nNote: AIDE is highly configurable at install time. These commands assume the \"aide.conf\" file is under the \"/etc\" directory.\n\nUse the following command to determine if the file is in another location:\n\n# find / -name aide.conf\n\nCheck the \"aide.conf\" file to determine if the \"xattrs\" rule has been added to the rule list being applied to the files and directories selection lists.\n\nAn example rule that includes the \"xattrs\" rule follows:\n\nAll= p+i+n+u+g+s+m+S+sha512+acl+xattrs+selinux\n/bin All # apply the custom rule to the files in bin\n/sbin All # apply the same custom rule to the files in sbin\n\nIf the \"xattrs\" rule is not being used on all uncommented selection lines in the \"/etc/aide.conf\" file, or extended attributes are not being checked by another file integrity tool, this is a finding.','Configure the file integrity tool to check file and directory extended attributes.\n\nIf AIDE is installed, ensure the \"xattrs\" rule is present on all uncommented file and directory selection lists.'),('V-204576',3,'The Red Hat Enterprise Linux operating system must limit the number of concurrent sessions to 10 for all accounts and/or account types.','Operating system management includes the ability to control the number of users and user sessions that utilize an operating system. Limiting the number of allowed users and sessions per user is...','Verify the operating system limits the number of concurrent sessions to \"10\" for all accounts and/or account types by issuing the following command:\n\n# grep \"maxlogins\" /etc/security/limits.conf /etc/security/limits.d/*.conf\n\n* hard maxlogins 10\n\nThis can be set as a global domain (with the * wildcard) but may be set differently for multiple domains.\n\nIf the \"maxlogins\" item is missing, commented out, or the value is not set to \"10\" or less for all domains that have the \"maxlogins\" item assigned, this is a finding.','Configure the operating system to limit the number of concurrent sessions to \"10\" for all accounts and/or account types.\n\nAdd the following line to the top of the /etc/security/limits.conf or in a \".conf\" file defined in /etc/security/limits.d/ :\n\n* hard maxlogins 10'),('V-204605',3,'The Red Hat Enterprise Linux operating system must display the date and time of the last successful account logon upon logon.','Providing users with feedback on when account accesses last occurred facilitates user recognition and reporting of unauthorized account use.','Verify users are provided with feedback on when account accesses last occurred.\n\nCheck that \"pam_lastlog\" is used and not silent with the following command:\n\n# grep pam_lastlog /etc/pam.d/postlogin\nsession required pam_lastlog.so showfailed\n\nIf \"pam_lastlog\" is missing from \"/etc/pam.d/postlogin\" file, or the silent option is present, this is a finding.','Configure the operating system to provide users with feedback on when account accesses last occurred by setting the required configuration options in \"/etc/pam.d/postlogin\".\n\nAdd the following line to the top of \"/etc/pam.d/postlogin\":\n\nsession required pam_lastlog.so showfailed'),('V-204608',3,'For Red Hat Enterprise Linux operating systems using DNS resolution, at least two name servers must be configured.','To provide availability for name resolution services, multiple redundant name servers are mandated. A failure in name resolution could lead to the failure of security functions requiring name...','Determine whether the system is using local or DNS name resolution with the following command:\n\n# grep hosts /etc/nsswitch.conf\nhosts: files dns\n\nIf the DNS entry is missing from the host\'s line in the \"/etc/nsswitch.conf\" file, the \"/etc/resolv.conf\" file must be empty.\n\nVerify the \"/etc/resolv.conf\" file is empty with the following command:\n\n# ls -al /etc/resolv.conf\n-rw-r--r-- 1 root root 0 Aug 19 08:31 resolv.conf\n\nIf local host authentication is being used and the \"/etc/resolv.conf\" file is not empty, this is a finding.\n\nIf the DNS entry is found on the host\'s line of the \"/etc/nsswitch.conf\" file, verify the operating system is configured to use two or more name servers for DNS resolution.\n\nDetermine the name servers used by the system with the following command:\n\n# grep nameserver /etc/resolv.conf\nnameserver 192.168.1.2\nnameserver 192.168.1.3\n\nIf less than two lines are returned that are not commented out, this is a finding.\n\nVerify that the \"/etc/resolv.conf\" file is immutable with the following command:\n\n# sudo lsattr /etc/resolv.conf\n\n----i----------- /etc/resolv.conf\n\nIf the file is mutable and has not been documented with the Information System Security Officer (ISSO), this is a finding.','Configure the operating system to use two or more name servers for DNS resolution.\n\nEdit the \"/etc/resolv.conf\" file to uncomment or add the two or more \"nameserver\" option lines with the IP address of local authoritative name servers. If local host resolution is being performed, the \"/etc/resolv.conf\" file must be empty. An empty \"/etc/resolv.conf\" file can be created as follows:\n\n# echo -n > /etc/resolv.conf\n\nAnd then make the file immutable with the following command:\n\n# chattr +i /etc/resolv.conf\n\nIf the \"/etc/resolv.conf\" file must be mutable, the required configuration must be documented with the Information System Security Officer (ISSO) and the file must be verified by the system file integrity tool.');
/*!40000 ALTER TABLE `Findings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Findings_Commands`
--

DROP TABLE IF EXISTS `Findings_Commands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Findings_Commands` (
  `idFinding` varchar(45) NOT NULL,
  `idFinding_Command` int NOT NULL,
  `Command` varchar(255) DEFAULT NULL,
  `Admin` varchar(45) DEFAULT 'N',
  PRIMARY KEY (`idFinding`,`idFinding_Command`),
  CONSTRAINT `fkIdFinding` FOREIGN KEY (`idFinding`) REFERENCES `Findings` (`idFinding`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Findings_Commands`
--

LOCK TABLES `Findings_Commands` WRITE;
/*!40000 ALTER TABLE `Findings_Commands` DISABLE KEYS */;
INSERT INTO `Findings_Commands` VALUES ('V-204452',1,'grep -i clean_requirements_on_remove /etc/yum.conf','N'),('V-204461',1,'pwck -r','N'),('V-204486',1,'cat /etc/fstab | grep /dev/shm','N'),('V-204486',2,'mount | grep /dev/shm','N'),('V-204493',1,'grep /home /etc/fstab','N'),('V-204494',1,'grep /var /etc/fstab','N'),('V-204495',1,'grep /var/log/audit /etc/fstab','N'),('V-204495',2,'mount | grep \"/var/log/audit\"','N'),('V-204496',1,'systemctl is-enabled tmp.mount','N'),('V-204496',2,'grep -i /tmp /etc/fstab','N'),('V-204498',1,'yum list installed aide','N'),('V-204498',2,'find / -name aide.conf','Y'),('V-204499',1,'yum list installed aide','N'),('V-204499',2,'find / -name aide.conf','Y'),('V-204576',1,'grep \"maxlogins\" /etc/security/limits.conf /etc/security/limits.d/*.conf','N'),('V-204605',1,'grep pam_lastlog /etc/pam.d/postlogin','N'),('V-204608',1,'grep hosts /etc/nsswitch.conf','N'),('V-204608',2,'ls -al /etc/resolv.conf','N'),('V-204608',3,'grep nameserver /etc/resolv.conf','N'),('V-204608',4,'lsattr /etc/resolv.conf','Y');
/*!40000 ALTER TABLE `Findings_Commands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Severities`
--

DROP TABLE IF EXISTS `Severities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Severities` (
  `idSeverity` int NOT NULL,
  `Severity_Description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idSeverity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Severities`
--

LOCK TABLES `Severities` WRITE;
/*!40000 ALTER TABLE `Severities` DISABLE KEYS */;
INSERT INTO `Severities` VALUES (1,'High'),(2,'Medium'),(3,'Low');
/*!40000 ALTER TABLE `Severities` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-12-26  2:07:14
