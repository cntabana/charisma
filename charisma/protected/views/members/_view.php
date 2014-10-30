<div class="view">

	<?php echo GxHtml::encode($data->getAttributeLabel('id')); ?>:
	<?php echo GxHtml::link(GxHtml::encode($data->id), array('view', 'id' => $data->id)); ?>
	<br />

	<?php echo GxHtml::encode($data->getAttributeLabel('cardnumber')); ?>:
	<?php echo GxHtml::encode($data->cardnumber); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('title')); ?>:
	<?php echo GxHtml::encode($data->title); ?>
	<br />	
	<?php echo GxHtml::encode($data->getAttributeLabel('firstname')); ?>:
	<?php echo GxHtml::encode($data->firstname); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('middlename')); ?>:
	<?php echo GxHtml::encode($data->middlename); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('lastname')); ?>:
	<?php echo GxHtml::encode($data->lastname); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('issuedate')); ?>:
	<?php echo GxHtml::encode($data->issuedate); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('expireddate')); ?>:
	<?php echo GxHtml::encode($data->expireddate); ?>
	<br />
	<?php /*
	<?php echo GxHtml::encode($data->getAttributeLabel('birthday')); ?>:
	<?php echo GxHtml::encode($data->birthday); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('sex')); ?>:
	<?php echo GxHtml::encode($data->sex); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('phonenumber')); ?>:
	<?php echo GxHtml::encode($data->phonenumber); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('address')); ?>:
	<?php echo GxHtml::encode($data->address); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('nationality')); ?>:
	<?php echo GxHtml::encode($data->nationality); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('status')); ?>:
	<?php echo GxHtml::encode($data->status); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('type')); ?>:
	<?php echo GxHtml::encode($data->type); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('photo')); ?>:
	<?php echo GxHtml::encode($data->photo); ?>
	<br />
	*/ ?>

</div>